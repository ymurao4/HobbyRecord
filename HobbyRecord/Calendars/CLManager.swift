//
//  CLManager.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/08/31.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class CLManager: ObservableObject {

    @Published var calendar: Calendar = Calendar.current
    @Published var minimumDate: Date = Date()
    @Published var maximunDate: Date = Date()
    @Published var selectedDate: Date! = nil

    init(calendar: Calendar, minmumDate: Date, maximumDate: Date) {
        self.calendar = calendar
        self.minimumDate = minmumDate
        self.maximunDate = maximumDate
    }

}
