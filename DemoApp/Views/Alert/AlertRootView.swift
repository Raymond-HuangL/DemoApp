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
            Button {
                alertManager.showStrongAlert("This is a strong alert")
            } label: {
                Text("Show Strong Alert")
            }
            Button {
                alertManager.showWeakAlert("This is a weak alert")
            } label: {
                Text("Show Weak Alert")
            }

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
            .padding(.bottom, 20)
            
            Button {
                let alertId = alertManager.showAlert("This alert will auto dismiss")
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    Task { @MainActor in
                        alertManager.dismissAlert(with: alertId)
                    }
                }
            } label: {
                Text("Show Alert Auto Dismiss")
            }
            Button {
                alertManager.showAlert("This is first alert")
                let alertId = alertManager.showAlert("This alert will auto dismiss")
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    Task { @MainActor in
                        alertManager.dismissAlert(with: alertId)
                    }
                }
            } label: {
                Text("Show Two Alert, Auto Dismiss Last")
            }
            .padding(.bottom, 20)
            
            Button {
                Task {
                    alertManager.showAlert("This normal alert with count 1")
                    
                    try? await Task.sleep(for: .seconds(1))
                    
                    alertManager.showAlert("This normal alert with count 2",nil,
                        [
                            .init(title: "Confirm 2", action: {
                            })
                        ]
                    )
                }
            } label: {
                Text("Show 2 Normal Alert")
            }
            
            Button {
                Task {
                    alertManager.showStrongAlert("This strong alert with count 1")
                    
                    try? await Task.sleep(for: .seconds(1))
                    
                    alertManager.showStrongAlert("This strong alert with count 2")
                }
            } label: {
                Text("Show 2 Strong Alert")
            }
            
            Button {
                Task {
                    alertManager.showWeakAlert("This weak alert with count 1")
                    
                    try? await Task.sleep(for: .seconds(1))
                    
                    alertManager.showWeakAlert("This weak alert with count 2")
                }
            } label: {
                Text("Show 2 Weak Alert")
            }
            .padding(.bottom, 20)
            
            
            Button {
                Task {
                    alertManager.showAlert("This is a normal alert")
                    
                    try? await Task.sleep(for: .seconds(1))
                    
                    alertManager.showStrongAlert("This is a strong alert")
                }
            } label: {
                Text("Show Strong Alert After Normal")
            }
            
            Button {
                Task {
                    alertManager.showStrongAlert("This is a strong alert")
                    
                    try? await Task.sleep(for: .seconds(1))
                    
                    alertManager.showAlert("This is a normal alert")
                }
            } label: {
                Text("Show Normal Alert After Strong")
            }
            
            Button {
                Task {
                    alertManager.showAlert("This is a normal alert")
                    
                    try? await Task.sleep(for: .seconds(1))
                    
                    alertManager.showWeakAlert("This is a weak alert")
                }
            } label: {
                Text("Show Weak Alert After Normal")
            }
            
            Button {
                Task {
                    alertManager.showWeakAlert("This is a weak alert")
                    
                    try? await Task.sleep(for: .seconds(1))
                    
                    alertManager.showAlert("This is a normal alert")
                }
            } label: {
                Text("Show Normal Alert After Weak")
            }
                        
            Button {
                Task {
                    alertManager.showWeakAlert("This is a weak alert")
                    
                    try? await Task.sleep(for: .seconds(1))
                    
                    alertManager.showStrongAlert("This is a strong alert")
                }
            } label: {
                Text("Show Strong Alert After Weak")
            }
            
            Button {
                Task {
                    alertManager.showStrongAlert("This is a strong alert")
                    
                    try? await Task.sleep(for: .seconds(1))
                    
                    alertManager.showWeakAlert("This is a weak alert")
                }
            } label: {
                Text("Show Weak Alert After Strong")
            }
            .padding(.bottom, 20)
            
            Button {
                Task {
                    let result: TestAlertResult = await alertManager.showAlert("This alert result will return while click", nil, [.init(title: "first", result: .first), .init(title: "second", result: .second)])
                    
                    print("click \(result) button")
                }
            } label: {
                Text("Show Alert With Click Result")
            }
            .padding(.bottom, 20)
        }
    }
}

enum TestAlertResult: AlertResult {
    case cancel
    case first
    case second
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
