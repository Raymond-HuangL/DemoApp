//
//  TestPresentedView.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/8/3.
//

import SwiftUI
import DataFlow
import ViewFlow

struct TestPresentedView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @SharedState var presentState: TestPresentState

    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            Button("Dismiss Modal") {
                presentationMode.wrappedValue.dismiss()
                presentState.fullScreenPresent = true
            }
        }
    }
}

struct TestPresentedView_Previews: PreviewProvider {
    static var previews: some View {
        TestPresentedView()
    }
}
