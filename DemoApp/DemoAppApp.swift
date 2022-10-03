//
//  DemoAppApp.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/8/1.
//

import SwiftUI
import Combine
import PresentFlow

@main
struct DemoAppApp: App {
    
    var monitorCancellable: AnyCancellable
    
    init() {
        self.monitorCancellable = PresentMonitor.shared.addObserver(MonitorObserver.shared)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
