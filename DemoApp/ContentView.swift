//
//  ContentView.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/8/1.
//

import SwiftUI
import DataFlow
import ViewFlow

struct ContentView: View {
    
    @SharedState var presentState: TestPresentState
    
    var body: some View {
        VStack {
            Button {
//                presentState.fullScreenPresent = true
                presentState.isPresent = true
            } label: {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
