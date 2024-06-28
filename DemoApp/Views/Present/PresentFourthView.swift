//
//  PresentFourthView.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/22.
//

import SwiftUI

struct PresentFourthView: VoidPresentableView {
    @Environment(\.presentManager) var presentManager
    @Environment(\.presentLevel) var level
    
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
                        presentManager.dismissTopView()
                        presentManager.dismissTopView()
                    }) {
                        Text("Dismiss Four Presented View")
                    }
                    
                    Button(action: {
                        presentManager.dismissToRootView()
                    }) {
                        Text("Dismiss To Root View")
                    }
                    
                    Button(action: {
                        presentManager.send(action: .dismissToViewOnLevel(level - 4))
                    }) {
                        Text("Dismiss To Level \(level - 4)")
                    }
                    
                    Button(action: {
                        presentManager.send(action: .dismissToViewOnRoute(PresentSecondView.defaultRoute))
                    }) {
                        Text("Dismiss To Route Of '\(PresentSecondView.defaultRoute.description)'")
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
                        presentManager.send(action: .present(PresentFirstOtherView.self, baseOnLevel: 0))
                        presentManager.present(PresentSecondOtherView.self)
                    }) {
                        Text("Present Second Other View On First With Three Step")
                    }
                    Button(action: {
                        presentManager.send(action: .present(PresentFirstOtherView.self, baseOnLevel: 0))
                        presentManager.present(PresentSecondView.self)
                    }) {
                        Text("Present First Other View On Root And Sencond")
                    }
                }
            }
        }
        VStack {
            Text("Fourth View")
            Spacer()
        }
    }
}

struct PresentFourthView_Previews: PreviewProvider {
    static var previews: some View {
        PresentFourthView()
    }
}
