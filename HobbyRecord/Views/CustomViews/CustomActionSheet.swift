//
//  CustomActionSheet.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct CustomActionSheet: View {

    @Binding var isActionSheet: Bool
    private let buttons: [[String]] = [["gear", "Setting"]]

    var body: some View {

        VStack(alignment: .leading, spacing: 15) {

            ForEach(buttons, id: \.self) { button in

                ChoicesButton(isActionSheet: self.$isActionSheet, button: button)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.top, 20)
        .padding(.horizontal)
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(25)
    }
}

struct ChoicesButton: View {

    @Binding var isActionSheet: Bool
    var button: [String]

    var body: some View {

        VStack {

            Button(action: {

                self.switchFunction(button: self.button)
            }) {

                HStack {

//                    Image(systemName: button[0])
                    Text(button[1])
                    Spacer()
                }
                .foregroundColor(.orange)
                .padding(.vertical, 3)
                .padding(.horizontal)
            }
            Divider()
        }
    }

    private func switchFunction(button: [String]) {

        switch button[0] {
        case "gear":
            self.isActionSheet.toggle()
        default:
            return
        }
    }
}
