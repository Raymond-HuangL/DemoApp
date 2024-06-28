//
//  PushSecondView.swift
//  DemoApp
//
//  Created by 黄磊 on 2023/7/28.
//

import SwiftUI

struct PushSecondView: VoidPushableView {
    @Environment(\.navStack) var navStack
    @Environment(\.presentManager) var presentManager
    @Environment(\.dismiss) var dismiss
    
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
        .navigationTitle("Second View")
    }
}
