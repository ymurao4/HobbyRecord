//
//  CustomNabbar.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct CustomNavbar: View {

    @Binding var isActionSheet: Bool

    var clManager: CLManager
    private let dayOfTheWeek: [String] = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    var cellWidth: CGFloat

    var body: some View {

        VStack(alignment: .trailing) {

            Spacer()

            Button(action: {

                self.isActionSheet.toggle()
            }) {

                Image(systemName: "gear")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 18)
                    .foregroundColor(.orange)
            }

            HStack(spacing: 0) {

                ForEach(dayOfTheWeek, id: \.self) { row in

                    Text(row.uppercased())
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(self.dayOfTheWeekColor(row: row))
                        .frame(width: self.cellWidth, height: 20)
                }
            }
            .padding(.bottom, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: 110)
        .background(Color(UIColor.systemGray6).opacity(0.9))
    }

    private func dayOfTheWeekColor(row: String) -> Color {
        switch row {
        case "sun":
            return Color.red
        case "sat":
            return Color.blue
        default:
            return Color.pr(9)
        }
    }
}
