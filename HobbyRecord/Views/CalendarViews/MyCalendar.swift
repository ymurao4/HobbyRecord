//
//  MyCalendar.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/19.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import SwiftUI


struct MyCalendar: UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<MyCalendar>) -> MyCalendarController {
        let calendar: MyCalendarController = .init()
        return calendar
    }

    func updateUIViewController(_ calendar: MyCalendarController, context: UIViewControllerRepresentableContext<MyCalendar>) {
        // MARK: - TODO
    }

}
