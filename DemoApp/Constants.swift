//
//  Constants.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/22.
//

import Foundation
import ViewFlow

enum RouteTo {
    static let firstView = PresentFirstView.defaultRoute
    static let secondView = ViewRoute<Void>("PresentSecondView")
    static let thirdView = ViewRoute<String>("PresentThirdView")
    static let fourthView = ViewRoute<Void>("PresentFourthView")
}

let s_ViewRouteFirst = ViewRoute<Void>("first")
