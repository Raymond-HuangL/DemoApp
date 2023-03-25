//
//  Constants.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/22.
//

import Foundation
import ViewFlow
import PresentFlow

enum RouteTo {
    static let firstView = PresentFirstView.defaultRoute
    static let secondView = ViewRoute<Void>(routeId: "PresentSecondView")
    static let thirdView = ViewRoute<String>(routeId: "PresentThirdView")
    static let fourthView = ViewRoute<Void>(routeId: "PresentFourthView")
}

let s_ViewRouteFirst = ViewRoute<Void>(routeId: "first")
