//
//  NotificationRootView.swift
//  DemoApp
//
//  Created by 黄磊 on 2026/1/25.
//

import SwiftUI
import ViewFlow
import UIKit

struct NotificationRootView: View {
    @SharedState var notificationState: NotificationState
    
    var body: some View {
        ZStack {
            Color.white
            switch notificationState.innerState {
            case .unauthorized:
                Button("请求授权") {
                    $notificationState.send(action: .requestAuthorization)
                }
            case .requestingAuthorization:
                Text("请求授权中...")
            case .requestAuthorizationFailed(let error):
                VStack {
                    Text("请求授权失败: \(error.localizedDescription)")
                    Button("重新请求授权") {
                        $notificationState.send(action: .requestAuthorization)
                    }
                }
            case .authorized(let serverState):
                ZStack {
                    switch serverState {
                    case .sendingDeviceToken(_):
                        Text("注册推送 Token 中...")
                    case .sendingFailed(let error, let data):
                        VStack {
                            Text("注册推送 Token 失败: \(error.localizedDescription)")
                            Button("重新注册") {
                                $notificationState.send(action: .saveDeviceToken(data))
                            }
                        }
                    case .ready(_):
                        self.content
                    }
                }
            }
        }
    }
    
    // 发送推送后将应用置于后台
    @MainActor
    private func sendPushAndGoToBackground(_ push: PushData) {
        // 使用私有 API 将应用置于后台
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        Task { @MainActor in
            // 先 sleep 1 秒
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            $notificationState.send(action: .sendPush(push))
        }
    }
    
    var content: some View {
        List {
            // 1、普通推送，都显示横幅，点击不处理，分前台/后台
            Section(header: Text("1. 普通推送 - 横幅")) {
                Button("前台测试") {
                    var push = PushData()
                    push.category = "normal"
                    push.title = "普通推送"
                    push.body = "这是一条普通推送，显示横幅，点击不处理"
                    push.pushDetail = "{}"
                    $notificationState.send(action: .sendPush(push))
                }
                Button("后台测试") {
                    var push = PushData()
                    push.category = "normal"
                    push.title = "普通推送"
                    push.body = "这是一条普通推送，显示横幅，点击不处理"
                    push.pushDetail = "{}"
                    sendPushAndGoToBackground(push)
                }
            }
            
            // 2、普通推送弹窗，前台接收到当作点击，后台点击弹窗
            Section(header: Text("2. 普通推送 - 弹窗")) {
                Button("前台测试") {
                    var push = PushData()
                    push.category = "showAlert"
                    push.title = "弹窗推送"
                    push.body = "这是一条弹窗推送，前台接收当作点击，后台点击弹窗"
                    push.pushDetail = "{}"
                    $notificationState.send(action: .sendPush(push))
                }
                Button("后台测试") {
                    var push = PushData()
                    push.category = "showAlert"
                    push.title = "弹窗推送"
                    push.body = "这是一条弹窗推送，前台接收当作点击，后台点击弹窗"
                    push.pushDetail = "{}"
                    sendPushAndGoToBackground(push)
                }
            }
            
            // 3、普通推送，都显示横幅，打开界面，分前台/后台
            Section(header: Text("3. 普通推送 - 打开界面")) {
                Button("前台测试") {
                    var push = PushData()
                    push.category = "showDetailPage"
                    push.title = "打开界面推送"
                    push.body = "这是一条打开界面推送，都显示横幅，点击打开详情页"
                    push.pushDetail = "{\"name\":\"测试通知\",\"detail\":\"这是通知详情内容\"}"
                    $notificationState.send(action: .sendPush(push))
                }
                Button("后台测试") {
                    var push = PushData()
                    push.category = "showDetailPage"
                    push.title = "打开界面推送"
                    push.body = "这是一条打开界面推送，都显示横幅，点击打开详情页"
                    push.pushDetail = "{\"name\":\"测试通知\",\"detail\":\"这是通知详情内容\"}"
                    sendPushAndGoToBackground(push)
                }
            }
            
            // 4、普通推送，前台接收插入弹窗，点击打开界面，后台点击打开界面
            Section(header: Text("4. 普通推送 - 弹窗后打开界面")) {
                Button("前台测试") {
                    var push = PushData()
                    push.category = "showPageWithAlert"
                    push.title = "弹窗后打开界面"
                    push.body = "这是一条弹窗后打开界面的推送"
                    push.pushDetail = "{\"name\":\"测试通知\",\"detail\":\"这是通知详情内容\",\"injectAlert\":{\"title\":\"确认打开\",\"message\":\"是否打开通知详情？\"}}"
                    $notificationState.send(action: .sendPush(push))
                }
                Button("后台测试") {
                    var push = PushData()
                    push.category = "showPageWithAlert"
                    push.title = "弹窗后打开界面"
                    push.body = "这是一条弹窗后打开界面的推送"
                    push.pushDetail = "{\"name\":\"测试通知\",\"detail\":\"这是通知详情内容\",\"injectAlert\":{\"title\":\"确认打开\",\"message\":\"是否打开通知详情？\"}}"
                    sendPushAndGoToBackground(push)
                }
            }
            
            // 5、普通推送，不显示横幅，前台执行特定操作
            Section(header: Text("5. 普通推送 - 执行操作")) {
                Button("前台测试") {
                    var push = PushData()
                    push.category = "executeAction"
                    push.title = "执行操作推送"
                    push.body = "这是一条执行操作的推送，不显示横幅"
                    push.pushDetail = "{}"
                    $notificationState.send(action: .sendPush(push))
                }
                Button("后台测试") {
                    var push = PushData()
                    push.category = "executeAction"
                    push.title = "执行操作推送"
                    push.body = "这是一条执行操作的推送，不显示横幅"
                    push.pushDetail = "{}"
                    sendPushAndGoToBackground(push)
                }
            }
            
            // 6、复杂内容推送，都显示横幅，打开界面，分前台/后台
            Section(header: Text("6. 复杂内容推送")) {
                Button("前台测试") {
                    var push = PushData()
                    push.category = "complexContent"
                    push.title = "复杂内容推送"
                    push.body = "这是一条复杂内容推送，都显示横幅，点击打开详情页"
                    push.pushDetail = "{\"name\":\"复杂内容通知\",\"detail\":\"这是复杂内容通知的详情，包含图片等多媒体内容\"}"
                    $notificationState.send(action: .sendPush(push))
                }
                Button("后台测试") {
                    var push = PushData()
                    push.category = "complexContent"
                    push.title = "复杂内容推送"
                    push.body = "这是一条复杂内容推送，都显示横幅，点击打开详情页"
                    push.pushDetail = "{\"name\":\"复杂内容通知\",\"detail\":\"这是复杂内容通知的详情，包含图片等多媒体内容\"}"
                    sendPushAndGoToBackground(push)
                }
            }
            
            // 7、静默推送，执行特定操作
            Section(header: Text("7. 静默推送 - 执行操作")) {
                Button("前台测试") {
                    var push = PushData()
                    push.category = "silenceNotification"
                    push.title = "静默推送"
                    push.body = "这是一条静默推送，执行特定操作"
                    push.pushDetail = "{}"
                    push.contentAvailable = true
                    $notificationState.send(action: .sendPush(push))
                }
                Button("后台测试") {
                    var push = PushData()
                    push.category = "silenceNotification"
                    push.title = "静默推送"
                    push.body = "这是一条静默推送，执行特定操作"
                    push.pushDetail = "{}"
                    push.contentAvailable = true
                    sendPushAndGoToBackground(push)
                }
            }
            
            // 8、静默推送，执行特定操作后横幅，分前台/后台
            Section(header: Text("8. 静默推送 - 执行操作后横幅")) {
                Button("前台测试") {
                    var push = PushData()
                    push.category = "silenceNotificationWithBanner"
                    push.title = "静默推送"
                    push.body = "这是一条静默推送，执行特定操作后显示横幅"
                    push.pushDetail = "{}"
                    push.contentAvailable = true
                    $notificationState.send(action: .sendPush(push))
                }
                Button("后台测试") {
                    var push = PushData()
                    push.category = "silenceNotificationWithBanner"
                    push.title = "静默推送"
                    push.body = "这是一条静默推送，执行特定操作后显示横幅"
                    push.pushDetail = "{}"
                    push.contentAvailable = true
                    sendPushAndGoToBackground(push)
                }
            }
            
            // 测试说明
            Section(header: Text("测试说明")) {
                VStack(alignment: .leading) {
                    Text("后台测试功能:")
                        .font(.headline)
                    Text("- 点击后台测试按钮后，应用会自动发送推送并退到后台")
                    Text("- 等待推送通知到达后，点击通知查看效果")
                    Text("- 此功能使用私有 API，仅用于测试环境")
                }
                .foregroundColor(.gray)
                .font(.system(size: 14))
            }
        }
    }
}

struct NotificationRootView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationRootView()
    }
}
