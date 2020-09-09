//
//  CustomActionSheet.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct CustomActionSheet: View {

    private let buttons: [[String]] = [["star", "Add to Favorites"], ["gear", "Setting"]]

    var body: some View {

        VStack(alignment: .leading, spacing: 15) {

            ForEach(buttons, id: \.self) { button in

                ChoicesButton(imageName: button[0], text: button[1])
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

    var imageName: String
    var text: String

    var body: some View {

        VStack {

            Button(action: {

            }) {

                HStack {

                    Image(systemName: imageName)
                    Text(text)
                    Spacer()
                }
                .padding(.vertical, 3)
                .padding(.horizontal)
            }
            Divider()
        }
    }
}
