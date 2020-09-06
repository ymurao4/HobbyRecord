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
    var clManager: CLManager
    var hobbyVM: HobbyViewModel

    var body: some View {
        VStack {
            Text(D.getTextFromDate(date: self.clManager.selectedDate))

        }
        .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height - 140)
        .clipped()
        .background(Color.defaultColor(colorScheme: colorScheme))
        .cornerRadius(15)
        .shadow(color: Color.init(red: 0.4, green: 0.4, blue: 0.4), radius: 100, x: 0, y: 0)
        .onDisappear {
            self.clManager.selectedDate = nil
        }
    }

}
