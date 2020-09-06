//
//  D.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/06.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

struct D {

    static func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "M-d-yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }

    static func formatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        formatter.locale = .current
        formatter.dateFormat = "M-d-yyyy"
        return formatter
    }

}
