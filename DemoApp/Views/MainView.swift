//
//  MainView.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/21.
//

import SwiftUI
import PresentFlow

struct MainView: View {
    var body: some View {
        PresentFlowView {
            TabView {
                PresentRootView()
                    .tabItem {
                        Image(systemName: "circle.grid.3x3")
                            .font(.system(size: 20))
                        Text("Present")
                    }
            }
        }
        .registerPresentOn { presentCenter in
            presentCenter.registePresentableView(PresentThirdView.self, for: RouteTo.thirdView)
            presentCenter.registePresentableView(PresentFourthView.self, for: RouteTo.fourthView)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
