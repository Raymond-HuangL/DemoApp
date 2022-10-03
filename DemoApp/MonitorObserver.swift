//
//  MonitorObserver.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/26.
//

import Foundation
import PresentFlow

class MonitorObserver: PresentMonitorOberver {
    
    public static var shared: MonitorObserver = .init()
    
    func receivePresentEvent(_ event: PresentEvent) {
        switch event {
        case .presentFailed(let route, let targetRouteNotFound):
            print("Present route '\(route.description)' failed. The \(targetRouteNotFound.description)")
        case .dismissFailed(let targetRouteNotFound):
            print("Dismiss failed. The \(targetRouteNotFound.description)")
        case .freezeFailed(let targetRouteNotFound):
            print("Freeze failed. The \(targetRouteNotFound.description)")
        case .unfreezeFailed(let targetRouteNotFound):
            print("Unfreeze failed. The \(targetRouteNotFound.description)")
        case .fatalError(let string):
            print("Fatal error: \(string)")
        }
    }
    
    
}
