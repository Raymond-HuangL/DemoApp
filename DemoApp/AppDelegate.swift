//
//  AppDelegate.swift
//  DemoApp
//
//  Created by 黄磊 on 2025/9/28.
//


#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
import UserNotifications
import PushManager
import Logger
import NetworkAbility
import Ability

#if os(iOS)
class AppDelegate: NotificationAppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}
#elseif os(macOS)
class AppDelegate: NotificationAppDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
    }
}

#endif
