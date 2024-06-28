//
//  PushFirstOtherView.swift
//  DemoApp
//
//  Created by 黄磊 on 2023/7/28.
//

import SwiftUI

struct PushFirstOtherView: PushableView {
    @Environment(\.navStack) var navStack
    @Environment(\.presentManager) var presentManager
    
    init(_ data: String) {
    }
    
    var content: some View {
        VStack {
            Button {
                navStack?.pop()
            } label: {
                Text("Pop Top View")
            }
            .padding(.bottom, 20)
            
            Button {
                presentManager.present(PresentFirstView.self)
            } label: {
                Text("Present First View")
            }
        }
        .navigationTitle("First Other View")
    }
}
