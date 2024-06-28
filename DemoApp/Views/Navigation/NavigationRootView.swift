//
//  NavigationRootView.swift
//  DemoApp
//
//  Created by 黄磊 on 2023/7/28.
//

import SwiftUI

struct NavigationRootView: View {
    
    @Environment(\.navStack) var navStack
    
    var body: some View {
        // NavigationView {
            VStack {
                Button {
                    navStack?.push(PushFirstView())
                } label: {
                    Text("Push One View")
                }
                
                Button {
                    navStack?.push(PushFirstView.self)
                } label: {
                    Text("Push One View With Type")
                }
                
                Button {
                    navStack?.push(PushFirstView.defaultRoute)
                } label: {
                    Text("Push One View With Route")
                }
                
                Button {
                    navStack?.push(PushFirstView.self)
                    navStack?.push(PushSecondView.self)
                } label: {
                    Text("Push Two View")
                }
                
                Button {
                    navStack?.push(PushFirstView.self)
                    navStack?.push(PushSecondView.self)
                    navStack?.push(PushThirdView.self)
                    navStack?.push(PushFourthView.self)
                } label: {
                    Text("Push Four View")
                }
                
                // NavigationLink(destination: PushFirstView()) {
                //     Text("Go to Detail")
                // }
                // .isDetailLink(false)
            }
            .navigationTitle("Navigation Root")
        // }
    }
}

extension SharedNavigationStackId {
    static let root = SharedNavigationStackId(stackId: "Root")
}
