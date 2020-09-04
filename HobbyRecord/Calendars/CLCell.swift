//
//  CLCell.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct CLCell: View {

    @ObservedObject var hobbyVM = HobbyViewModel()

    var clDate: CLDate
    var color: Color

    @State private var isImage: Bool = false
    @State private var imageName: String?

    var body: some View {
        VStack {
            Text(clDate.getText())
                .foregroundColor(color)
                .font(.system(size: 18))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            if isImage {
                Image(imageName!)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.primary.opacity(0.9))
            }
            Spacer()
        }
        .padding(.top, 5)
        .onAppear {
            self.showImage()
        }
    }

    private func showImage() {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        formatter.locale = .current
        formatter.dateFormat = "M-d-yyyy"

        for hobbyCellVM in self.hobbyVM.hobbyCellViewModels {
            let date = hobbyCellVM.hobby.date
            let imageName = hobbyCellVM.hobby.icon
            if formatter.date(from: date) == clDate.date {
                if let imageName = imageName {
                    self.isImage = true
                    self.imageName = imageName
                }
            }
        }
    }
}
