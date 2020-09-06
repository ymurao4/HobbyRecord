//
//  CLMonth.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct CLMonth: View {

    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var clManager: CLManager
    @ObservedObject var hobbyVM = HobbyViewModel()
    @Binding var isDetailView: Bool

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
                .padding(.top, 5)
                .foregroundColor(Color.primary.opacity(0.9))
            VStack(spacing: 0) {
                ForEach(monthsArray, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(row, id: \.self) { column in
                            VStack(alignment: .center, spacing: 7 ) {
                                if self.isThisMonth(date: column) {
                                    CLCell(clDate: CLDate(
                                        hobbyVM: self.hobbyVM,
                                        date: column,
                                        clManager: self.clManager,
                                        isToday: self.isToday(date: column),
                                        isSelected: self.isSelectedDate(date: column)
                                    ), color: self.getColor(row, column))
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
            return Color.red
        case row.last:
            return Color.blue
        default:
            return Color.primary.opacity(0.9)
        }
    }

    private func isThisMonth(date: Date) -> Bool {
        return self.clManager.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
    }

    private func dateTapped(date: Date) {
        self.clManager.selectedDate = date
        withAnimation {
            self.isDetailView.toggle()
        }
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
