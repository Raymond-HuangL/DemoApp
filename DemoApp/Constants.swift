//
//  Constants.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/22.
//

import Foundation
import PresentFlow

enum RouteTo {
    static let firstView = PresentFirstView.defaultRoute
    static let secondView = PresentRoute<Void>(routeId: "PresentSecondView")
    static let thirdView = PresentRoute<String>(routeId: "PresentThirdView")
    static let fourthView = PresentRoute<Void>(routeId: "PresentFourthView")
}

let s_presentRouteFirst = PresentRoute<Void>(routeId: "first")
