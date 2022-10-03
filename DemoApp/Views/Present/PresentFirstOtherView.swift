//
//  PresentFirstOtherView.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/22.
//

import SwiftUI
import PresentFlow

struct PresentFirstOtherView: VoidPresentableView {
    
    @Environment(\.presentManager) var presentManager
    @Environment(\.dismiss) var dismiss
    
    var content: some View {
        ZStack {
            VStack {
                Button(action: {
                    presentManager.dismiss()
                }) {
                    Text("Dismiss Use Manager")
                }
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Dismiss Use Default")
                }
                
                Button(action: {
                    presentManager.send(action: .present(PresentSecondView.self, isFullCover: true))
                }) {
                    Text("Present Second View")
                }
            }
            VStack {
                Text("First Other View")
                Spacer()
            }
        }
    }
}

struct PresentFirstOtherView_Previews: PreviewProvider {
    static var previews: some View {
        PresentFirstOtherView()
    }
}
