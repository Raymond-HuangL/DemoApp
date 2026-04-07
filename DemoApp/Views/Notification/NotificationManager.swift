//
//  NotificationManager.swift
//  DemoApp
//
//  Created by 黄磊 on 2026/3/24.
//

import DataFlow
import PushManager
import Logger
import TriggerableAction

extension Store where State == NotificationState {
    @MainActor
    func registerRemoteNotifications() {
        /*
         1、普通推送，都显示横幅，点击不处理，分前台/后台
         2、普通推送弹窗，前台接收到当作点击，后台点击弹窗
         3、普通推送，都显示横幅，打开界面，分前台/后台
         4、普通推送，前台接收插入弹窗，点击打开界面，后台点击打开界面
         5、普通推送，不显示横幅，前台执行特定操作，后台点击执行特定操作
         6、复杂内容推送，都显示横幅，打开界面，分前台/后台
         7、静默推送，执行特定操作
         8、静默推送，执行特定操作后横幅，分前台/后台
         */
        
        // 1、注册普通推送弹窗
        PushManager.shared.register(on: "normal")
        
        // 2、注册推送弹窗
        PushManager.shared.registerAction(on: "showAlert", clickAction: ShowAlertAction(on: s_appSceneId))
        
        // 3、注册推送打开界面
        PushManager.shared.registerShowPage(type: NotificationDetailView.self, on: s_appSceneId) // showDetailPage
        
        // 4、注册推送拆入弹窗后打开界面
        PushManager.shared.registerAction(on: "showPageWithAlert", clickAction: ShowPageAction<NotificationDetailView>(on: s_appSceneId), inAppHandler: .injectAlert(.sound))
        
        // 5、注册推送执行特定操作
        PushManager.shared.registerAction(on: "executeAction", clickAction: ExecuteBlockAction { notification in
            LogInfo("execute action")
        }, inAppHandler: .treatAsClick([]))
        
        // 6、注册复杂内容打开界面
        PushManager.shared.registerAction(on: "complexContent", clickAction: ShowPageAction<NotificationDetailView>(on: s_appSceneId))
        
        // 7、注册静默推送，后台处理
        PushManager.shared.register(on: "silenceNotification") { (data: String) async throws in
            LogInfo("receive silenceNotification")
            return true
        }
        
        // 8、注册静默推送，处理后显示横幅
        PushManager.shared.registerAction(
            on: "silenceNotificationWithBanner",
            clickAction: ShowAlertAction(),
            inAppHandler: .waitMoreContentArrived(.banner),
            contentDeliverHandler: TriggerCompletionAction<String, Bool>(block: { data, completion in
                LogInfo("receive silenceNotificationWithBanner")
                // 收到静默通知，执行对应逻辑，执行完成毁掉
                // Store<MessageState>.shared.send(action: MessageAction.receivedRemoteNotifications(item.data))
                completion(true)
            })
        )
    }
}
