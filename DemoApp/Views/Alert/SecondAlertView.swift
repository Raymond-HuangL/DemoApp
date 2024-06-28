//
//  SecondAlertView.swift
//  DemoApp
//
//  Created by 黄磊 on 2023/3/12.
//

import SwiftUI

struct SecondAlertView: VoidPresentableView {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentManager) var presentManager
    @Environment(\.alertManager) var alertManager
    
    var content: some View {
        ZStack {
            VStack {
                VStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Dismiss")
                    }
                }
                .padding(.bottom, 20)
                
                VStack {
                    Button(action: {
                        alertManager.showAlert("This is a simple alert")
                    }) {
                        Text("Show Alert")
                    }
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    presentManager.send(action: .present(SecondAlertView.self, isFullCover: true))
                }) {
                    Text("Show Full Test View")
                }
            }
            VStack {
                Text("Strong Alert View")
                Spacer()
            }
        }
    }
}

struct SecondAlertView_Previews: PreviewProvider {
    static var previews: some View {
        SecondAlertView()
            .modifier(AlertModifier())
    }
}
