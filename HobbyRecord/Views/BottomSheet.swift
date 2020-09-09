//
//  BottomSheet.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct BottomSheet: View {

    var body: some View {

        VStack {

            VStack {

                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.bottom, 5)

            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(15)
            .padding()

            ScrollView(.vertical, showsIndicators: false) {

                VStack {

                    ForEach(1..<15, id: \.self) { count in

                        Text("Searched Place")
                    }
                }
                .padding()
                .padding(.top)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(15)
    }
}
