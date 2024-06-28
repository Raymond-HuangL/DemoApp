//
//  PushFourthView.swift
//  DemoApp
//
//  Created by 黄磊 on 2023/7/28.
//

import SwiftUI

struct PushFourthView: VoidPushableView {
    @Environment(\.navStack) var navStack
    
    var content: some View {
        VStack {
            Button {
                navStack?.pop()
            } label: {
                Text("Pop Top View")
            }
            .padding(.bottom, 20)
                        
            Button {
                navStack?.pushOnRoot(PushFirstOtherView.defaultRoute, "")
            } label: {
                Text("Push First Other View On Root")
            }
            
            Button {
                navStack?.push(PushSecondOtherView.self, baseOn: PushFirstView.defaultRoute.eraseToAnyRoute())
            } label: {
                Text("Push Second Other View On First")
            }
            .padding(.bottom, 20)
            
            Button {
                navStack?.remove(with: PushSecondView.defaultRoute)
            } label: {
                Text("Remove Second View")
            }
            Button {
                navStack?.remove(with: PushThirdView.defaultRoute)
            } label: {
                Text("Remove Third View")
            }
            Button {
                navStack?.remove(with: PushFourthView.defaultRoute)
            } label: {
                Text("Remove Forth View")
            }
        }
        .navigationTitle("Forth View")
    }
}
