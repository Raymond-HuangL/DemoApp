//
//  NotificationDetailView.swift
//  DemoApp
//
//  Created by 黄磊 on 2026/3/22.
//


import SwiftUI
import PushManager


struct NotificationDetailView: PushPresentableView {
    struct Detail: Codable {
        let name: String
        let detail: String
    }
    
    let detail: Detail
    
    init(_ data: Detail) {
        self.detail = data
    }
    
    static let pushCategory: String = "showDetailPage"
    
    var content: some View {
        VStack(spacing: 20) {
            Text(detail.name)
                .font(.title)
                .fontWeight(.bold)
            Text(detail.detail)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .navigationTitle("通知详情")
    }
}
