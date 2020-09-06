//
//  ClViewController.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct CLViewController: View {

    @ObservedObject var clManager: CLManager
    @ObservedObject var hobbyVM: HobbyViewModel
    @Binding var isDetailView: Bool

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(0..<numberOfMonth()) { index in
                    CLMonth(clManager: self.clManager, hobbyVM: self.hobbyVM, isDetailView: self.$isDetailView, monthOffset: index)
                        .allowsHitTesting(self.isDetailView ? false : true)
                }
            }
        }
    }

    private func numberOfMonth() -> Int {
        return clManager.calendar.dateComponents([.month], from: clManager.minimumDate, to: CLMaximumDateMonthLastDay()).month! + 1
    }

    private func CLMaximumDateMonthLastDay() -> Date {
        var components = clManager.calendar.dateComponents([.year, .month, .day], from: clManager.maximunDate)
        components.month! += 1
        components.day = 0
        return clManager.calendar.date(from: components)!
    }

}
