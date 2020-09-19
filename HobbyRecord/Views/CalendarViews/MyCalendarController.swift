//
//  MyCalendarController.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/19.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import FSCalendar

class MyCalendarController: UIViewController, FSCalendarDelegateAppearance {

    let secondary: UIColor = .parse(0xE0B355)
    let primary  : UIColor = .parse(0x346C7C)
    let tersiary : UIColor = .parse(0xE7EEEF)

    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    fileprivate weak var calendar: FSCalendar!

    override func loadView() {
        let width: CGFloat = UIScreen.main.bounds.width
        let frame: CGRect  = .init(x: 0, y: 0, width: width, height: UIScreen.main.bounds.height - 300)
        let view:  UIView  = .init(frame: frame)
        self.view = view

        let calendar: FSCalendar = .init(frame: frame)
        calendar.allowsMultipleSelection = false
        calendar.dataSource = self
        calendar.delegate = self

        view.addSubview(calendar)
        self.calendar = calendar

        calendar.calendarHeaderView.backgroundColor = UIColor.clear
        calendar.calendarWeekdayView.backgroundColor = UIColor.clear
        calendar.appearance.headerTitleColor = UIColor.label.withAlphaComponent(0.9)
        calendar.appearance.weekdayTextColor = UIColor.label.withAlphaComponent(0.9)

        calendar.appearance.eventSelectionColor = self.tersiary
        calendar.appearance.eventDefaultColor = self.primary
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)

        calendar.appearance.todaySelectionColor = self.primary
        calendar.appearance.selectionColor = UIColor.clear
        calendar.appearance.todayColor = self.primary

        calendar.appearance.titleWeekendColor = self.secondary
        calendar.appearance.titleDefaultColor = self.primary

        calendar.appearance.borderRadius = 0
        calendar.today = nil


        calendar.swipeToChooseGesture.isEnabled = true
        let scopeGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)));
        scopeGesture.delegate = self
        calendar.addGestureRecognizer(scopeGesture)
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        self.calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "Cell")
        self.calendar.scope = .month
        self.calendar.select(Date.init())
        self.calendar.accessibilityIdentifier = "calendar"
    }

}


extension MyCalendarController: FSCalendarDataSource, FSCalendarDelegate {

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        debugPrint("did select date \(self.formatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.formatter.string(from: $0)})
        debugPrint("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }

    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame.size.height = bounds.height
        self.view.layoutIfNeeded()
    }

    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return UIImage(named: "barbell ")
    }

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {

        let cell = calendar.dequeueReusableCell(withIdentifier: "Cell", for: date, at: position)
        cell.imageView.contentMode = .scaleAspectFit
        return cell
    }
}


extension MyCalendarController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        debugPrint("UIGestureRecognizer")
        return true
    }
}

extension UIColor {

    static func parse(_ hex: UInt32, alpha: Double = 1.0) -> UIColor {
        let red   = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue  = CGFloat(hex & 0xFF)/256.0
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
    }
}
