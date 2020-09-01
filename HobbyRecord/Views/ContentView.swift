//
//  ContentView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/08/28.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    // カレンダーの範囲
    var clManager = CLManager(
        calendar: Calendar.current,
        minmumDate: Date(),
        maximumDate: Date().addingTimeInterval(60*60*24*365*2))

    private let dayOfTheWeek: [String] = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    private var cellWidth: CGFloat {
        calculateCellWidth()
    }

    //今日を初期画面に表示するのは、scrollViewReader待ち
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(dayOfTheWeek, id: \.self) { row in
                    Text(row.uppercased())
                        .fontWeight(.semibold)
                        .foregroundColor(self.dayOfTheWeekColor(row: row))
                        .frame(width: self.cellWidth, height: 20)
                }
            }
            CLViewController(clManager: self.clManager)
        }
    }

    private func calculateCellWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width
        return width / 7
    }

    private func dayOfTheWeekColor(row: String) -> Color {
        switch row {
        case "sun":
            return Color.red
        case "sat":
            return Color.blue
        default:
            return Color.primary
        }
    }

}


struct CLCell: View {
    var clDate: CLDate
    var color: Color

    var body: some View {
        Text(clDate.getText())
            .foregroundColor(color)
            .font(.system(size: 18))
            .minimumScaleFactor(0.9)
    }
}


struct CLViewController: View {

    @ObservedObject var clManager: CLManager

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(0..<numberOfMonth()) { index in
                    CLMonth(clManager: self.clManager, monthOffset: index)
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



struct CLMonth: View {

    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var clManager: CLManager

    let monthOffset: Int
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    let daysPerWeek: Int = 7
    var monthsArray: [[Date]] {
        monthArray()
    }
    private var cellWidth: CGFloat {
        calculateCellWidth()
    }

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(getMonthHeader())
            VStack(spacing: 0) {
                ForEach(monthsArray, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(row, id: \.self) { column in
                            VStack(alignment: .center, spacing: 7 ) {
                                if self.isThisMonth(date: column) {
                                    CLCell(clDate: CLDate(
                                        date: column,
                                        clManager: self.clManager,
                                        isToday: self.isToday(date: column),
                                        isSelected: self.isSelectedDate(date: column)
                                    ), color: self.getColor(row, column))
                                        .padding(.top, 5)
                                    Image("barbell")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Spacer()
                                } else {
                                    Text("")
                                }
                            }
                            .frame(width: self.cellWidth, height: self.cellWidth * 1.5)
                            .cornerRadius(10)
                            .background(self.isSelectedDate(date: column) && self.isThisMonth(date: column) ? Color(UIColor.systemGray5) : Color.defaultColor(colorScheme: self.colorScheme))
                            .onTapGesture { self.dateTapped(date: column) }
                        }
                    }
                }
            }
        }
    }

    private func calculateCellWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width
        return width / 7
    }

    // sunday -> red, saturday -> blue, the others -> .primary
    private func getColor(_ row: [Date], _ column: Date) -> Color {
        switch column {
        case row.first:
            return .red
        case row.last:
            return .blue
        default:
            return .primary
        }
    }

    private func isThisMonth(date: Date) -> Bool {
        return self.clManager.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
    }

    private func dateTapped(date: Date) {
        self.clManager.selectedDate = date
    }

    // 日付が1日分ずれているが、これにより直る
    private func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "M-d-yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }

    private func monthArray() -> [[Date]] {
        var rowArray: [[Date]] = [[]]
        for row in 0 ..< (numberOfDays(offset: monthOffset) / 7) {
            var columnArray: [Date] = []
            for column in 0...6 {
                let abc = self.getDateAtIndex(index: (row * 7) + column)
                columnArray.append(abc)
            }
            rowArray.append(columnArray)
        }
        return rowArray
    }

    private func getMonthHeader() -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = clManager.calendar
        headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: clManager.calendar.locale)

        return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
    }

    private func getDateAtIndex(index: Int) -> Date {
        let firstOfMonth = firstOfMonthForOffset()
        let weekDay = clManager.calendar.component(.weekday, from: firstOfMonth)
        var startOffset = weekDay - clManager.calendar.firstWeekday
        startOffset += startOffset >= 0 ? 0 : daysPerWeek
        var dateComponents = DateComponents()
        dateComponents.day = index - startOffset

        return clManager.calendar.date(byAdding: dateComponents, to: firstOfMonth)!
    }

    private func numberOfDays(offset: Int) -> Int {
        let firstOfMonth = firstOfMonthForOffset()
        let rangeOfWeeks = clManager.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth)

        return (rangeOfWeeks?.count)! * daysPerWeek
    }

    private func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = monthOffset

        return clManager.calendar.date(byAdding: offset, to: CLFirstDateMonth())!
    }

    private func CLFormatDate(date: Date) -> Date {
        let components = clManager.calendar.dateComponents(calendarUnitYMD, from: date)

        return clManager.calendar.date(from: components)!
    }

    private func CLFormatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
        let refDate = CLFormatDate(date: referenceDate)
        let clampedDate = CLFormatDate(date: date)

        return refDate == clampedDate
    }

    private func CLFirstDateMonth() -> Date {
        var components = clManager.calendar.dateComponents(calendarUnitYMD, from: clManager.minimumDate)
        components.day = 1

        return clManager.calendar.date(from: components)!
    }

    private func isToday(date: Date) -> Bool {
        return CLFormatAndCompareDate(date: date, referenceDate: Date())
    }

    private func isSpecialDate(date: Date) -> Bool {
        return isSelectedDate(date: date)
    }

    private func isSelectedDate(date: Date) -> Bool {
        if clManager.selectedDate == nil {
            return false
        }
        return CLFormatAndCompareDate(date: date, referenceDate: clManager.selectedDate)
    }

}

