//
//  NotificationState.swift
//  DemoApp
//
//  Created by 黄磊 on 2026/1/22.
//

import DataFlow
import ViewFlow
import PushManager
import Foundation
import Logger
import Ability
import NetworkAbility
import UIKit
import AlertFlow
import ToastFlow


/// 通知相关的操作枚举
/// 定义了与推送通知相关的各种操作，如请求授权、保存设备令牌、发送推送等
enum NotificationAction: Action {
    /// 请求推送通知授权
    case requestAuthorization
    /// 请求推送通知授权失败
    case requestAuthorizationFailed(Error)
    /// 保存设备令牌
    case saveDeviceToken(Data)
    /// 保存设备令牌失败 (失败原因，deviceToken)
    case saveDeviceTokenFailed(Error, Data)
    /// 更新设备推送 ID
    case updateDevicePushId(Int)
    /// 发送推送消息
    case sendPush(PushData)
}

struct NotificationState: FullSharableState {
    enum ServerState {
        /// 发送 deviceToken 中  (deviceToken)
        case sendingDeviceToken(Data)
        /// 发送 deviceToken 失败 (失败原因，deviceToken)
        case sendingFailed(Error, Data)
        /// 服务已准备好 (deviceAppId)
        case ready(Int)
    }
    
    enum AuthState {
        /// 未授权
        case unauthorized
        /// 请求授权中
        case requestingAuthorization
        /// 请求授权中
        case requestAuthorizationFailed(Error)
        /// 授权成功，保存 token 中
        case authorized(ServerState)
    }
    
    
    typealias BindAction = NotificationAction
    var innerState: AuthState = .unauthorized
    
    static func loadReducers(on store: Store<NotificationState>) {
        store.registerRemoteNotifications()
        store.registerDefault { [weak store] (state, action) in
            guard let store = store else { return }
            switch action {
            case .requestAuthorization:
                state.innerState = .requestingAuthorization
                store.requestAuthorization()
            case .requestAuthorizationFailed(let error):
                state.innerState = .requestAuthorizationFailed(error)
            case .saveDeviceToken(let deviceToken):
                state.innerState = .authorized(.sendingDeviceToken(deviceToken))
                store.saveDeviceToken(deviceToken)
            case .saveDeviceTokenFailed(let error, let deviceToken):
                state.innerState = .authorized(.sendingFailed(error, deviceToken))
            case .updateDevicePushId(let newDevicePushId):
                state.innerState = .authorized(.ready(newDevicePushId))
            case .sendPush(var pushData):
                if case let .authorized(.ready(deviceAppId)) = state.innerState {
                    pushData.devicePushId = deviceAppId
                    store.sendPush(pushData)
                }
                print("")
            }
        }
    }
}

extension Store where State == NotificationState {
    func requestAuthorization() {
        Task {
            do {
                let deviceToken = try await PushManager.shared.requestAuthorizationAndRegisterForRemoteNotifications()
                
                self.dispatch(action: .saveDeviceToken(deviceToken))
            } catch {
                self.dispatch(action: .requestAuthorizationFailed(error))
                LogInfo("推送注册失败: \(error.localizedDescription)")
            }
        }
    }
    
    struct PushRegisterParam: Encodable {
        /// App状态<0-开发状态 1-发布状态>
        enum AppState: Int, Codable, Sendable {
            /// 开发状态
            case developer = 0
            /// 发布状态
            case release
        }
        let deviceUUID: String
        let appBundleId: String
        let deviceToken: String
        let appState: AppState
    }
    struct RegisterResponse: Decodable {
        let devicePushId : Int
    }
    
    @MainActor
    func saveDeviceToken(_ deviceToken: Data) {
        guard let serverURL = URL(string: s_serverHost + "/action/Notification.register") else {
            return
        }
        
        Task {
            let dataString = deviceToken.map { String(format: "%02x", $0) }.joined()
            #if DEBUG
            let appState: PushRegisterParam.AppState = .developer
            #else
            let appState: PushRegisterParam.AppState = .release
            #endif
            let sendData = PushRegisterParam(
                deviceUUID: UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString,
                appBundleId: Bundle.main.bundleIdentifier!,
                deviceToken: dataString,
                appState: appState
            )
            do {
                let response: RegisterResponse = try await Ability.http.httpRequest(serverURL, .post, body: sendData)
                
                LogInfo("deviceToken 发送成功，devicePushId=\(response.devicePushId)")
                
                NotificationState.sharedStore.dispatch(action: .updateDevicePushId(response.devicePushId))
            } catch {
                self.dispatch(action: .saveDeviceTokenFailed(error, deviceToken))
                LogInfo("保存 deviceToken 失败: \(error.localizedDescription)")
            }
        }
    }
    
    func sendPush(_ pushData: PushData) {
        guard let serverURL = URL(string: s_serverHost + "/action/Notification.send") else {
            return
        }
                
        Task {
            let response: SucceedResponse = try await Ability.http.httpRequest(serverURL, .post, body: pushData)
            Toast.show(message: "推送发送\(response.succeed ? "成功" : "失败")", on: s_appSceneId)
        }
    }
}

extension NotificationState {
    struct PushRegisterParam: Encodable {
        /// App状态<0-开发状态 1-发布状态>
        enum AppState: Int, Codable, Sendable {
            /// 开发状态
            case developer = 0
            /// 发布状态
            case release
        }
        let deviceUUID: String
        let appBundleId: String
        let deviceToken: String
        let appState: AppState
    }
    struct RegisterResponse: Decodable {
        let devicePushId : Int
    }
}

struct PushData: Encodable {
    /// 下面两个属性必须存在一个
    /// 设备推送ID
    var devicePushId: Int?
    
    /// 类别，不同类别在app绑定不同处理方式，20字符
    var category: String?

    /// 线程ID，同一个类别如果想在锁屏界面分组就设置这个，比如即时通讯按人分组，20字符
    var threadId: String?

    /// 标题，显示上1行 24中文，64英文，折中 40字符
    var title: String?

    /// 标题本地化，20字符
    var titleLocKey: String?
    
    /// 标题本地化替换，200字符
    var titleLocArgs: String?

    /// 副标题，显示上1行 24中文，53英文，折中 40字符，显示上应该与title一致，只是字母宽度导致
    var subtitle: String?

    /// 推送内容，显示上锁屏4行 96中文，170英文，折中 160字符，这里实际上限和整体上限一致
    var body: String?

    /// 内容本地化，20字符
    var locKey: String?

    /// 内容本地化替换，200字符
    var locArgs: String?

    /// 推送详情ID，3933字符，设定3000字符，多余93字符，刚好用户字段
    var pushDetail: String?
    
    /// 查看按钮本地化，20字符
    var actionLocKey: String?

    /// 标记
    var badge: Int?

    /// 声音，100字符
    var sound: String?

    /// 是否有更多内容，会调用AppDelegate中的方法，但用户可关闭
    var contentAvailable: Bool = false

    /// 是否存在附加内容，需要客户端使用 Extension
    var mutableContent: Bool = false

    /// 在这个时间后生效
    var validateAt: Date?
}

struct SucceedResponse: Decodable {
    let succeed: Bool
}
