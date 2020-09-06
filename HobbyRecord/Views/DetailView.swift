//
//  DetailView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/04.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct DetailView: View {

    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var detailVM: DetailViewModel
    var clManager: CLManager
    var hobbyVM: HobbyViewModel

    init(clManager: CLManager, hobbyVM: HobbyViewModel) {
        self.clManager = clManager
        self.hobbyVM = hobbyVM
        self.detailVM = DetailViewModel(date: clManager.selectedDate, hobbyVM: hobbyVM)
    }

    var body: some View {
        VStack {
            Text(D.getTextFromDate(date: self.clManager.selectedDate))
                .font(.system(size: 40))
                .padding(.top, 10)
            if self.detailVM.imageName != "" {
                Image(self.detailVM.imageName)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.primary.opacity(0.9))
            }
            Spacer()
    }
        .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height - 140)
        .clipped()
        .background(Color.defaultColor(colorScheme: colorScheme))
        .cornerRadius(15)
        .shadow(color: Color.init(red: 0.4, green: 0.4, blue: 0.4), radius: 100, x: 0, y: 0)
    }

}
