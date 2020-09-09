//
//  ContentView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/08/28.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct CalendarView: View {

    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var hobbyVM = HobbyViewModel()
    @State private var isDetailView: Bool = false
    @Binding var isActionSheet: Bool

    // カレンダーの範囲
    var clManager = CLManager(
        calendar: Calendar.current,
        minmumDate: Date(),
        maximumDate: Date().addingTimeInterval(60*60*24*365*2))

    private var cellWidth: CGFloat {
        calculateCellWidth()
    }

    //今日を初期画面に表示するのは、scrollViewReader待ち
    var body: some View {

        ZStack(alignment: .bottom) {

            VStack(spacing: 0) {

                CustomNavbar(isDetailView: $isDetailView, isActionSheet: $isActionSheet, clManager: clManager, cellWidth: cellWidth)
                CLViewController(clManager: clManager, hobbyVM: hobbyVM, isDetailView: $isDetailView)
            }

            if isDetailView {

                DetailView(clManager: self.clManager, hobbyVM: self.hobbyVM)
                    .padding(.bottom, 5)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }

    private func calculateCellWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width
        return width / 7
    }

    private func addButton() -> some View {

        Button(action: {

        }) {

            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.defaultColor(colorScheme: colorScheme))
                .padding()
        }
        .frame(width: 60, height: 60)
        .background(Color.orange)
        .cornerRadius(30)
        .padding(.trailing, 10)
    }

}

