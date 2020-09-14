//
//  IconSetting.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/14.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct IconSetting: View {

    @Binding var icon: String
    var kind: [String]

    var cellHeight: CGFloat {
        calCellHeight()
    }


    var body: some View {

        WaterfallGrid(0..<kind.count, id: \.self) { index in

            Button(action: {

                self.icon = self.kind[index]
            }) {

                ZStack(alignment: .bottom) {

                    Image(self.kind[index])
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.pr(9))
                        .padding(10)

                    if self.icon == self.kind[index] {

                        Rectangle()
                            .frame(width: 25, height: 2.0, alignment: .bottom)
                            .foregroundColor(Color.orange)
                    }
                }
            }
        }
        .gridStyle(columns: 6, spacing: 15)
        .scrollOptions(direction: .vertical, showsIndicators: false)
        .frame(width: UIScreen.main.bounds.width, height: cellHeight)
        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
    }

    private func calCellHeight() -> CGFloat {
        let count = self.kind.count
        let row = count / 6 + 1
        return CGFloat(row * 45)
    }

}

