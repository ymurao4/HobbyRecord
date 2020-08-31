//
//  CLDate.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/08/31.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import SwiftUI

struct CLDate {

    var date: Date
    let clManager: CLManager
    var isToday: Bool = false
    var isSelected: Bool = false

    init(date: Date, clManager: CLManager, isToday: Bool, isSelected: Bool) {
        self.date = date
        self.clManager = clManager
        self.isToday = isToday
        self.isSelected = isSelected
    }

    func getText() -> String {
        let day = formatDate(date: date, calendar: self.clManager.calendar)
        return day
    }

    func getColor() -> Color {
        let color = Color(UIColor.label)

        /*
        if isSelected {
            color = .red
        } else if isToday {
            color = .black
        } else if date < Date() {
            color = .blue
        } else if date > Date() {
            color = .yellow
        }
         */
        return color
    }

    func formatDate(date: Date, calendar: Calendar) -> String {
        let formatter = dateFormatter()
        return stringFrom(date: date, formatter: formatter, calendar: calendar)
    }

    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "d"
        return formatter
    }

    func stringFrom(date: Date, formatter: DateFormatter, calendar: Calendar) -> String {
        if formatter.calendar != calendar {
            formatter.calendar = calendar
        }
        return formatter.string(from: date)
    }

}
