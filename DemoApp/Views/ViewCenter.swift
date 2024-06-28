//
//  ViewCenter.swift
//  DemoApp
//
//  Created by 黄磊 on 2023/4/24.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

public class ViewCenter {
    
    public static var shared: ViewCenter = .init()
    
    #if !os(macOS)
    public var topViewController: UIViewController? {
        if var topVC = keyWindow?.rootViewController {
            while let aVC = topVC.presentedViewController {
                topVC = aVC
            }
            return topVC
        }
        return nil
    }

    public var keyWindow : UIWindow? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first { $0.isKeyWindow }
    }
    #endif
}
