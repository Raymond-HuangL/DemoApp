//
//  TestPresentState.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/8/3.
//

import DataFlow

struct TestPresentState: SharableState {
    
    typealias UpState = AppState
    
    var fullScreenPresent: Bool = false
    var isPresent: Bool = false
}
