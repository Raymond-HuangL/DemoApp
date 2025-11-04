//
//  DemoAppApp.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/8/1.
//

import SwiftUI
import Combine
@_exported import DataFlow
@_exported import PresentFlow
@_exported import NavigationFlow
@_exported import AlertFlow

@main
struct DemoAppApp: App {
    // 关联 AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var monitorCancellable: AnyCancellable
    
    init() {
        self.monitorCancellable = PresentMonitor.shared.addObserver(MonitorObserver.shared)
        NavigationCenter.shared.registerDefaultPushableView(PushFirstView.self)
        NavigationCenter.shared.registerDefaultPushableView(PushFirstOtherView.self)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.sceneId, s_appSceneId)
        }
        
        WindowGroup {
            MainView()
        }
    }
}
