//
//  PresentFirstView.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/22.
//

import SwiftUI

struct PresentFirstView: VoidPresentableView {
    
    @Environment(\.presentManager) var presentManager
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentLevel) var level
    
    var content: some View {
        ZStack {
            VStack {
                VStack {
                    Button(action: {
                        presentManager.dismissTopView()
                    }) {
                        Text("Dismiss Use Manager")
                    }
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Dismiss Use Default")
                    }
                }
                .padding(.bottom, 20)
                
                VStack {
                    Button(action: {
                        presentManager.send(action: .present(PresentSecondView.self, isFullCover: true))
                    }) {
                        Text("Present Second View")
                    }
                }
                .padding(.bottom, 20)
                
                VStack {
                    Button(action: {
                        presentManager.send(action: .freezeTopView())
                    }) {
                        Text("Freeze This View")
                    }
                    
                    Button(action: {
                        presentManager.send(action: .unfreezeViewOnLevel(level))
                    }) {
                        Text("Unfreeze This View")
                    }
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    let vc = PresentUIViewController()
                    vc.modalPresentationStyle = .fullScreen
                    ViewCenter.shared.topViewController?.present(vc, animated: true)
                }) {
                    Text("Present UIViewController")
                }
                   
            }
            VStack {
                Text("First View")
                Spacer()
            }
        }
    }
}

struct PresentFirstView_Previews: PreviewProvider {
    static var previews: some View {
        PresentFirstView()
    }
}
