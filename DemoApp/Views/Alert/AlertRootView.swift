//
//  AlertFlowRootView.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/12/25.
//

import SwiftUI
import ViewFlow
import DataFlow
import AlertFlow

struct AlertRootView: View {
    
    @Environment(\.presentManager) var presentManager
    @Environment(\.alertManager) var alertManager
    
    @ViewState var alertState: AlertViewState = .init()
    @State var alertCount = 1
    var maxAlertCount = 2
    
    var body: some View {
        VStack {
            Button {
                alertManager.showAlert("This is a normal alert")
            } label: {
                Text("Show Normal Alert")
            }
//            Button {
//                alertManager.showStrongAlert("This is a strong alert")
//            } label: {
//                Text("Show Strong Alert")
//            }
//            Button {
//                alertManager.showWeakAlert("This is a weak alert")
//            } label: {
//                Text("Show Weak Alert")
//            }

            Button(action: {
                alertManager.showAlert(
                    "Alert Title",
                    "alert message",
                    [
                        .init(title: "Delete", role: .destructive, action: {
                            
                        }),
                        .init(title: "Cancel", role: .cancel, action: {
                        }),
                        .init(title: "Confirm", action: {
                        })
                    ],
                    [
                        .init(title: "username", text: .init(get: {
                            ""
                        }, set: { _ in
                            
                        })),
                        .init(title: "password", text: .init(get: {
                            ""
                        }, set: { _ in
                            
                        }))
                    ]
                )
            }) {
                Text("Show Full Alert")
            }
//            Button {
//                let alertId = alertManager.showAlert("This alert will auto dismiss")
//                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
//                    alertManager.dismissAlert(with: alertId)
//                }
//            } label: {
//                Text("Show Alert Auto Dismiss")
//            }
            Button {
                alertCount = 1
                alertManager.showAlert("This alert with count \(alertCount)")
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    if self.alertCount < maxAlertCount {
                        self.alertCount += 1
                        alertManager.showAlert("This alert with count \(alertCount)")
                    } else {
                        // alertManager.dismissAlert(with: alertId)
                        timer.invalidate()
                    }
                }
            } label: {
                Text("Show \(maxAlertCount) Alert")
            }
            .padding(.bottom, 20)
            
            Button {
                presentManager.presentFullCover(SecondAlertView.self)
            } label: {
                Text("Show Alert On Presented Page")
            }
        }
    }
}

struct AlertRootView_Previews: PreviewProvider {
    static var previews: some View {
        AlertRootView()
            .modifier(PresentModifier())
            .modifier(AlertModifier())
    }
}

struct AlertViewState: StorableViewState {
    var name: String = ""
}
