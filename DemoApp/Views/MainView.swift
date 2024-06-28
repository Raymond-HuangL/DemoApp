//
//  MainView.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/21.
//

import SwiftUI
import NavigationFlow

struct MainView: View {
    
    @State var arrPath: [String] = []
    
    var body: some View {
        TabView {
            PresentRootView()
                .tabItem {
                    Image(systemName: "circle.grid.3x3")
                        .font(.system(size: 20))
                    Text("Present")
                }
            AlertRootView()
                .tabItem {
                    Image(systemName: "circle.grid.3x3")
                        .font(.system(size: 20))
                    Text("Alert")
                }
            NavigationRootView()
                // .modifier(NavigationStackModifier(shared: .root))
                .tabItem {
                    Image(systemName: "circle.grid.3x3")
                        .font(.system(size: 20))
                    Text("Navigation")
                }
        }
        .modifier(NavigationStackModifier(shared: .main))
        .modifier(AlertModifier())
        .modifier(PresentModifier())
        .registerPresentOn { presentCenter in
            presentCenter.registerPresentableView(PresentThirdView.self, for: RouteTo.thirdView)
            presentCenter.registerPresentableView(PresentFourthView.self, for: RouteTo.fourthView)
        }
        .registerPresentedModifier { content, sceneId, level in
            content
//                .modifier(NavigationStackModifier("Level-\(level)-"))
                .modifier(AlertModifier(level: level))
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
