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
    @State var isSheet: Bool = false
    private let buttons: [[String]] = [["star", "Record your hobby"], ["gear", "Setting"]]

    var body: some View {

        VStack(alignment: .leading, spacing: 15) {

            ForEach(buttons, id: \.self) { button in

                ChoicesButton(isActionSheet: self.$isActionSheet, isSheet: self.$isSheet, button: button)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.top, 20)
        .padding(.horizontal)
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(25)
        .sheet(isPresented: $isSheet) {
            AddHobbyView() // desired full screen
        }
    }
}

struct ChoicesButton: View {

    @Binding var isActionSheet: Bool
    @Binding var isSheet: Bool
    var button: [String]

    var body: some View {

        VStack {

            Button(action: {

                self.switchFunction(button: self.button)
            }) {

                HStack {

                    Image(systemName: button[0])
                    Text(button[1])
                    Spacer()
                }
                .padding(.vertical, 3)
                .padding(.horizontal)
            }
            Divider()
        }
    }

    private func switchFunction(button: [String]) {

        switch button[0] {
        case "star":
            self.isSheet.toggle()
            self.isActionSheet.toggle()
        case "gear":
            self.isActionSheet.toggle()
        default:
            return
        }
    }
}
