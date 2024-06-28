//
//  PushFirstView.swift
//  DemoApp
//
//  Created by 黄磊 on 2023/7/28.
//

import SwiftUI

struct PushFirstView: VoidPushableView, VoidPresentableView {
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
                        
            Button {
                dismiss()
            } label: {
                Text("Dismiss Top View")
            }
            .padding(.bottom, 20)
            
            Button {
                navStack?.push(PushSecondView.self)
            } label: {
                Text("Push Second View")
            }
            .padding(.bottom, 20)
            
            Button {
                presentManager.present(PushFirstView.self)
            } label: {
                Text("Present First View")
            }
        }
        .navigationTitle("First View")
    }
}
