//
//  CLManager.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/08/31.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

class CLManager: ObservableObject {

    @Published var calendar: Calendar = Calendar.current
    @Published var minimumDate: Date = Date()
    @Published var maximunDate: Date = Date()
    @Published var selectedDates: [Date] = []
    @Published var selectedDate: Date! = nil

    init(calendar: Calendar, minmumDate: Date, maximumDate: Date, selectedDates: [Date] = []) {
        self.calendar = calendar
        self.minimumDate = minmumDate
        self.maximunDate = maximumDate
        self.selectedDates = selectedDates
    }

    func selectedDatesContains(date: Date) -> Bool {
        if let _ = self.selectedDates.first(where: { calendar.isDate($0, inSameDayAs: date) }) {
            return true
        }
        return false
    }

    func selectedDatesFindIndex(date: Date) -> Int? {
        return self.selectedDates.firstIndex(where: { calendar.isDate($0, inSameDayAs: date) })
    }

}
