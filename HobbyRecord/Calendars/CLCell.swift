//
//  CLCell.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct CLCell: View {

    var clDate: CLDate
    var color: Color
    
    var body: some View {

        VStack(spacing: 5) {

            Text(clDate.getText())
                .foregroundColor(color)
                .font(.system(size: 18))
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            if self.clDate.hobbyies.count != 0 {

                HStack {

                    DateCell(hobby: self.clDate.hobbyies[0])

                    if self.clDate.hobbyies.count >= 2 {
                        DateCell(hobby: self.clDate.hobbyies[1])
                    }
                }

                HStack {

                    if self.clDate.hobbyies.count >= 3 {
                        DateCell(hobby: self.clDate.hobbyies[2])
                    }

                    if self.clDate.hobbyies.count >= 4 {
                        DateCell(hobby: self.clDate.hobbyies[3])
                    }
                }

                if self.clDate.hobbyies.count >= 5 {

                    Text("and more")
                        .font(.system(size: 9))
                        .foregroundColor(Color.pr(9))
                        .padding(.bottom, -10)
                }
            }
            Spacer()
        }
        .padding(.top, 5)
    }
}


struct DateCell: View {

    var hobby: Hobby

    var body: some View {

        HStack {

            if hobby.icon != "" {

                Image(hobby.icon)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.primary.opacity(0.8))
            } else {

                Image(systemName: "questionmark.circle")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.primary.opacity(0.9))
            }
        }
    }
}
