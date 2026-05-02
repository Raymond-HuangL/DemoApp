//
//  DemoAppApp.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/8/1.
//

import SwiftUI
import Combine
import KeychainWrapper
@_exported import DataFlow
@_exported import PresentFlow
@_exported import NavigationFlow
@_exported import AlertFlow

@main
struct DemoAppApp: App {
    // 关联 AppDelegate
    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #elseif os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    
    var monitorCancellable: AnyCancellable
    
    init() {
        self.monitorCancellable = PresentMonitor.shared.addObserver(MonitorObserver.shared)
        NavigationCenter.shared.registerDefaultPushableView(PushFirstView.self)
        NavigationCenter.shared.registerDefaultPushableView(PushFirstOtherView.self)
        KeychainWrapper.configDefault(
            with: Bundle.main.bundleIdentifier ?? "com.miejoy.App",
            accessGroup: nil
        )
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
