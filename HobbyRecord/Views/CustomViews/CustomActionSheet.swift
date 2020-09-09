//
//  CustomActionSheet.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct CustomActionSheet: View {

    @State var show: Bool = false

    var body: some View {

        VStack(spacing: 15) {

            Toggle(isOn: self.$show) {
                Text("Notification")
            }
            Toggle(isOn: self.$show) {
                Text("Notification")
            }
            Toggle(isOn: self.$show) {
                Text("Notification")
            }
            Toggle(isOn: self.$show) {
                Text("Notification")
            }
        }
        .padding(.top, 20)
        .padding(.horizontal)
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(25)
    }
}
