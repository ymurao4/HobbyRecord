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
    @ObservedObject var hobbyVM: HobbyViewModel
    @Binding var isDetailView: Bool
    var clManager: CLManager

    var cellWidth: CGFloat

    var body: some View {

//        CLViewController(clManager: clManager, hobbyVM: hobbyVM, isDetailView: $isDetailView)
        RootView()
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

