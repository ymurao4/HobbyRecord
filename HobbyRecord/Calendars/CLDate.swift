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

    @ObservedObject var hobbyVM: HobbyViewModel
    @ObservedObject var CLDateVM: CLDateHobbyViewModel

    var hobbyies: [Hobby] {

        getHobbies()
    }

    var date: Date
    let clManager: CLManager
    var isToday: Bool = false
    var isSelected: Bool = false

    init(hobbyVM: HobbyViewModel, date: Date, clManager: CLManager, isToday: Bool, isSelected: Bool) {
        self.hobbyVM = hobbyVM
        self.date = date
        self.clManager = clManager
        self.isToday = isToday
        self.isSelected = isSelected
        self.CLDateVM = CLDateHobbyViewModel(hobbyVM: hobbyVM)
    }

    func getText() -> String {

        let day = formatDate(date: date, calendar: self.clManager.calendar)
        return day
    }

    private func formatDate(date: Date, calendar: Calendar) -> String {

        let formatter = dateFormatter()
        return stringFrom(date: date, formatter: formatter, calendar: calendar)
    }

    private func dateFormatter() -> DateFormatter {

        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "d"
        return formatter
    }

    private func stringFrom(date: Date, formatter: DateFormatter, calendar: Calendar) -> String {

        if formatter.calendar != calendar {

            formatter.calendar = calendar
        }
        return formatter.string(from: date)
    }

    
    private func getHobbies() -> [Hobby] {

        var hobbies: [Hobby] = []

        for hobbyCellVM in self.hobbyVM.hobbyCellViewModels {
            let stringDate = hobbyCellVM.hobby.date
            if  stringDate == D.formatter.string(from: date) {

                hobbies.append(hobbyCellVM.hobby)
            }
        }
        return hobbies
    }

}
