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
    
    var monitorCancellable: AnyCancellable
    
    init() {
        self.monitorCancellable = PresentMonitor.shared.addObserver(MonitorObserver.shared)
        NavigationCenter.shared.registerDefaultPushableView(PushFirstView.self)
        NavigationCenter.shared.registerDefaultPushableView(PushFirstOtherView.self)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.sceneId, .custom("Second"))
        }
        
        WindowGroup {
            MainView()
        }
    }
}
