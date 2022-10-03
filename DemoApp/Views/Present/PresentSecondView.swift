//
//  PresentSecondView.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/22.
//

import SwiftUI
import PresentFlow

struct PresentSecondView: VoidPresentableView {
    @Environment(\.presentManager) var presentManager
    @Environment(\.presentLevel) var level
    
    var content: some View {
        ZStack {
            VStack {
                VStack {
                    Button(action: {
                        presentManager.dismiss()
                    }) {
                        Text("Dismiss Top View")
                    }
                    
                    Button(action: {
                        presentManager.dismiss()
                        presentManager.dismiss()
                    }) {
                        Text("Dismiss Two Presented View")
                    }
                    
                    Button(action: {
                        presentManager.dismissToRootView()
                    }) {
                        Text("Dismiss To Root View")
                    }
                    
                    Button(action: {
                        presentManager.send(action: .dismissToViewOnLevel(level - 2))
                    }) {
                        Text("Dismiss To Level \(level - 2)")
                    }
                    Button(action: {
                        presentManager.send(action: .dismissToViewOnLevel(level - 1))
                    }) {
                        Text("Dismiss To Level \(level - 1)")
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
                        presentManager.present(RouteTo.thirdView, "sencod")
                    }) {
                        Text("Present Third View")
                    }
                    Button(action: {
                        presentManager.send(action: .present(PresentSecondOtherView.self, baseOnRoute: PresentFirstView.defaultRoute))
                    }) {
                        Text("Present Second Other View On First")
                    }
                    Button(action: {
                        presentManager.send(action: .present(PresentFirstOtherView.self, baseOnLevel: 0))
                    }) {
                        Text("Present First Other View On Root")
                    }
                }
                .padding(.bottom, 20)
                VStack {
                    Button(action: {
                        presentManager.send(action: .freezeViewOnRoute(PresentFirstView.defaultRoute))
                    }) {
                        Text("Freeze First View")
                    }
                    
                    Button(action: {
                        presentManager.send(action: .unfreezeViewOnLevel(level - 1))
                    }) {
                        Text("Unfreeze First View")
                    }
                }
            }
        }
        VStack {
            Text("Second View")
            Spacer()
        }
    }
}

struct PresentSecondView_Previews: PreviewProvider {
    static var previews: some View {
        PresentSecondView()
    }
}
