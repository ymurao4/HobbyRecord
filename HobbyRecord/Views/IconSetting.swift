//
//  IconSetting.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/14.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct IconSetting: View {

    @Binding var icon: String
    var kind: [String]

    let column = GridItem(.adaptive(minimum: 30, maximum: 50))

    var cellHeight: CGFloat {

        calCellHeight()
    }


    var body: some View {

        ScrollView(showsIndicators: false) {

            LazyVGrid(columns: Array(repeating: column, count: 6), spacing: 20) {

                ForEach(kind, id: \.self) { item in

                    Button(action: { self.icon = item }) {

                        ZStack(alignment: .bottom) {

                            Image(item)
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.pr(9))
                                .padding(.bottom, 13)

                            if self.icon == item {

                                Rectangle()
                                    .frame(width: 25, height: 2.0, alignment: .bottom)
                                    .foregroundColor(Color.orange)
                            }
                        }
                    }
                }
            }
            .padding(.top, 10)
        }
        .frame(maxHeight: UIScreen.main.bounds.height * 0.65)
    }

    private func calCellHeight() -> CGFloat {
        let count = self.kind.count
        let row = count / 6 + 1
        return CGFloat(row * 40)
    }
}

