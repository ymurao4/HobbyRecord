//
//  CalendarViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Combine
import Foundation

class CalendarViewModel: ObservableObject {

    @Published var date: Date = Date()

    func nextMonth() {

        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: date)
        self.date = nextMonth!
    }

    func prevMonth() {

        let prevMonth = Calendar.current.date(byAdding: .month, value: -1, to: date)
        self.date = prevMonth!
    }
}
