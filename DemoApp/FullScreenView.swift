//
//  FullScreenView.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/8/3.
//

import SwiftUI
import DataFlow
import ViewFlow

struct FullScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    @SharedState var presentState: TestPresentState
    
    var body: some View {
        ZStack {
            Color.red.edgesIgnoringSafeArea(.all)
            Button("Dismiss Full Modal") {
                presentationMode.wrappedValue.dismiss()
                EnvironmentValues().dismiss()
                presentState.isPresent = true
            }
        }
    }
}

struct FullScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenView()
    }
}
