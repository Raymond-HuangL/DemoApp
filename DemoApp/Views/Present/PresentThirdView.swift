//
//  PresentThirdView.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/22.
//

import SwiftUI

struct PresentThirdView: PresentableView {
    
    @Environment(\.presentManager) var presentManager
    @Environment(\.presentLevel) var level
        
    var data: String
    
    init(_ data: String) {
        self.data = data
    }
    
    var content: some View {
        ZStack {
            VStack {
                VStack {
                    Button(action: {
                        presentManager.dismissTopView()
                    }) {
                        Text("Dismiss Top View")
                    }
                    
                    Button(action: {
                        presentManager.dismissTopView()
                        presentManager.dismissTopView()
                    }) {
                        Text("Dismiss Two Presented View")
                    }
                    
                    Button(action: {
                        presentManager.dismissTopView()
                        presentManager.dismissTopView()
                        presentManager.dismissTopView()
                    }) {
                        Text("Dismiss Three Presented View")
                    }
                    
                    Button(action: {
                        presentManager.dismissToRootView()
                    }) {
                        Text("Dismiss To Root View")
                    }
                    
                    Button(action: {
                        presentManager.send(action: .dismissToViewOnLevel(level - 3))
                    }) {
                        Text("Dismiss To Level \(level - 3)")
                    }
                    
                    Button(action: {
                        presentManager.send(action: .dismissToViewOnRoute(PresentFirstView.defaultRoute))
                    }) {
                        Text("Dismiss To Route Of '\(PresentFirstView.defaultRoute.description)'")
                    }
                }
                .padding(.bottom, 20)
                VStack {
                    Button(action: {
                        presentManager.present(RouteTo.fourthView)
                    }) {
                        Text("Present Fourth View")
                    }
                    Button(action: {
                        presentManager.send(action: .present(PresentSecondOtherView.self, baseOnRoute: PresentFirstView.defaultRoute))
                    }) {
                        Text("Present Second Other View On First")
                    }
                    Button(action: {
                        presentManager.send(action: .present(PresentFirstOtherView.self, baseOnLevel: 0))
                        presentManager.present(PresentSecondView.self)
                    }) {
                        Text("Present First Other View On Root And Sencond")
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
        }
        VStack {
            Text("Third View From \(data)")
            Spacer()
        }
    }
}

struct PresentThirdView_Previews: PreviewProvider {
    static var previews: some View {
        PresentThirdView("")
    }
}
