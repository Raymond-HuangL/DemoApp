//
//  AppDelegate.swift
//  DemoApp
//
//  Created by 黄磊 on 2025/9/28.
//

import UIKit
import UserNotifications
// import MJPushManager

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // 注册通知
        // PushManager.shared.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        //     guard granted else {
        //         print("用户拒绝了推送权限")
        //         return
        //     }
        //     
        //     UNUserNotificationCenter.current().getNotificationSettings { settings in
        //         guard settings.authorizationStatus == .authorized else {
        //             print("推送权限未授权")
        //             return
        //         }
        //         DispatchQueue.main.async {
        //             UIApplication.shared.registerForRemoteNotifications()
        //         }
        //     }
        // }

        // 消息推送
        // PushManager.shared.registerAction(
        //     on: "receiveMessage",
        //     contentDeliverHandler: TriggerBlock<(data: ReceiveMessage, completion: (Bool) -> Void)>(block: { (item) in
        //     // 后期考虑要不要弄成有回调的
        //     Store<MessageState>.shared.send(action: MessageAction.receivedRemoteNotifications(item.data))
        //     item.completion(true)
        // }),
        //     inAppHandler: .waitMoreContentArrived(.sound)
        // )
        
        // 注册弹窗
        // PushManager.shared.registerAction(on: "alert", clickAction: ClickShowAlert())
        
        return true
    }
    
    // 当收到设备令牌时调用
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("设备推送令牌: \(token)")
        
        // 在这里将令牌发送到你的服务器
        // PushManager.register(with: deviceToken)
    }
    
    // 注册推送失败时调用
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("推送注册失败: \(error.localizedDescription)")
    }
    
    // 前台收到通知时调用
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 配置前台通知展示方式
        completionHandler([.banner, .sound, .badge])
    }
    
    // 用户点击通知时调用
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // 处理通知点击事件
        let userInfo = response.notification.request.content.userInfo
        print("收到通知: \(userInfo)")
        
        completionHandler()
    }
}
