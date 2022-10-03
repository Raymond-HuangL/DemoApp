//
//  PresentRootView.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/21.
//

import SwiftUI
import PresentFlow

struct PresentRootView: View {
    
    @Environment(\.presentManager) var presentManager
    
    var body: some View {
        VStack {
            Button(action: {
                presentManager.present(PresentFirstView.self)
            }) {
                Text("Present One")
            }
            Button(action: {
                presentManager.present(PresentFirstView.self)
                presentManager.send(action: .present(PresentSecondView.self))
            }) {
                Text("Present Two")
            }
            Button(action: {
                presentManager.present(PresentFirstView.self)
                presentManager.send(action: .present(PresentSecondView.self))
                presentManager.send(action: .present(RouteTo.thirdView, "root"))
            }) {
                Text("Present Three")
            }
            Button(action: {
                presentManager.present(PresentFirstView.self)
                presentManager.send(action: .present(PresentSecondView.self))
                presentManager.send(action: .present(RouteTo.thirdView, "root"))
                presentManager.present(PresentFourthView.self)
            }) {
                Text("Present Four")
            }
//            Button(action: {
//                Store<PresentState>.shared.send(action: .present(MailView.self))
//            }) {
//                Text("Present Mail")
//            }
        }
    }
}

struct PresentRootView_Previews: PreviewProvider {
    static var previews: some View {
        PresentRootView()
    }
}
