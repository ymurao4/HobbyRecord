//
//  ContentView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/08/28.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State var isSheetPresented: Bool = true
    // カレンダーの範囲
    var clManager = CLManager(
        calendar: Calendar.current,
        minmumDate: Date(),
        maximumDate: Date().addingTimeInterval(60*60*24*365*2))

    var body: some View {
        VStack() {
            CLViewController(isPresented: self.$isSheetPresented, clManager: self.clManager)
        }
    }

    // not used
    private func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "M-d-yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CLCell: View {
    var clDate: CLDate
    var cellWidth: CGFloat

    var body: some View {
        Text(clDate.getText())
            .fontWeight(clDate.getFontWeight())
            .foregroundColor(clDate.getColor())
            .frame(width: cellWidth, height: cellWidth * 2)
            .font(.system(size: 20))
            .cornerRadius(cellWidth / 2)
            .border(Color.yellow)
    }
}


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

    func getFontWeight() -> Font.Weight {
        var fontWeight = Font.Weight.medium

        if isSelected, isToday {
            fontWeight = Font.Weight.heavy
        }
        return fontWeight
    }

    func getColor() -> Color {
        var color = Color.black

        if isSelected {
            color = .red
        } else if isToday {
            color = .black
        } else if date < Date() {
            color = .blue
        } else if date > Date() {
            color = .yellow
        }
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

struct CLViewController: View {

    @State private var currentPage = 0
    @Binding var isPresented: Bool
    @ObservedObject var clManager: CLManager

    var body: some View {
        VStack {
            PageView(appendMonthsArray(), currentPage: $currentPage)
        }
    }

    private func appendMonthsArray() -> [CLMonth] {
        var monthsArray: [CLMonth] = []
        for i in 0..<numberOfMonth() {
            monthsArray.append(CLMonth(isPresented: self.$isPresented, clManager: self.clManager, monthOffset: i))
        }
        return monthsArray
    }

    func numberOfMonth() -> Int {
        return clManager.calendar.dateComponents([.month], from: clManager.minimumDate, to: CLMaximumDateMonthLastDay()).month! + 1
    }

    func CLMaximumDateMonthLastDay() -> Date {
        var components = clManager.calendar.dateComponents([.year, .month, .day], from: clManager.maximunDate)
        components.month! += 1
        components.day = 0
        return clManager.calendar.date(from: components)!
    }

}

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

struct CLMonth: View {

    @Binding var isPresented: Bool
    @ObservedObject var clManager: CLManager

    let monthOffset: Int
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    let daysPerWeek: Int = 7
    var monthsArray: [[Date]] {
        monthArray()
    }
    let cellWidth: CGFloat = CGFloat(52)

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(monthsArray, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(row, id: \.self) { column in
                            HStack {
                                if self.isThisMonth(date: column) {
                                    CLCell(clDate: CLDate(
                                        date: column,
                                        clManager: self.clManager,
                                        isToday: self.isToday(date: column),
                                        isSelected: self.isSelectedDate(date: column)
                                        ),
                                           cellWidth: self.cellWidth)
                                        .onTapGesture { self.dateTapped(date: column) }
                                } else {
                                    Text("")
                                        .frame(width: self.cellWidth, height: self.cellWidth)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text(getMonthHeader()), displayMode: .inline)
        }
    }

    private func calculateCellWidth() -> CGFloat {
        let bounds = UIScreen.main.bounds.width
        let size = (bounds) / 7
        print(size)
        print(self.cellWidth)
        return size
    }

    func isThisMonth(date: Date) -> Bool {
        return self.clManager.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
    }

    private func dateTapped(date: Date) {
        if self.clManager.selectedDate != nil && self.clManager.calendar.isDate(self.clManager.selectedDate, inSameDayAs: date) {
                   self.clManager.selectedDate = nil
               } else {
                   self.clManager.selectedDate = date
               }
               self.isPresented = false
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

    func getMonthHeader() -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = clManager.calendar
        headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: clManager.calendar.locale)

        return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
    }

    func getDateAtIndex(index: Int) -> Date {
        let firstOfMonth = firstOfMonthForOffset()
        let weekDay = clManager.calendar.component(.weekday, from: firstOfMonth)
        var startOffset = weekDay - clManager.calendar.firstWeekday
        startOffset += startOffset >= 0 ? 0 : daysPerWeek
        var dateComponents = DateComponents()
        dateComponents.day = index - startOffset

        return clManager.calendar.date(byAdding: dateComponents, to: firstOfMonth)!
    }

    func numberOfDays(offset: Int) -> Int {
        let firstOfMonth = firstOfMonthForOffset()
        let rangeOfWeeks = clManager.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth)

        return (rangeOfWeeks?.count)! * daysPerWeek
    }

    func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = monthOffset

        return clManager.calendar.date(byAdding: offset, to: CLFirstDateMonth())!
    }

    func CLFormatDate(date: Date) -> Date {
        let components = clManager.calendar.dateComponents(calendarUnitYMD, from: date)

        return clManager.calendar.date(from: components)!
    }

    func CLFormatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
        let refDate = CLFormatDate(date: referenceDate)
        let clampedDate = CLFormatDate(date: date)

        return refDate == clampedDate
    }

    func CLFirstDateMonth() -> Date {
        var components = clManager.calendar.dateComponents(calendarUnitYMD, from: clManager.minimumDate)
        components.day = 1

        return clManager.calendar.date(from: components)!
    }

    func isToday(date: Date) -> Bool {
        return CLFormatAndCompareDate(date: date, referenceDate: Date())
    }

    func isSpecialDate(date: Date) -> Bool {
        return isSelectedDate(date: date)
    }

    private func isSelectedDate(date: Date) -> Bool {
        if clManager.selectedDate == nil {
            return false
        }
        return CLFormatAndCompareDate(date: date, referenceDate: clManager.selectedDate)
    }

}


struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @Binding var currentPage: Int

    init(_ views: [Page], currentPage: Binding<Int>) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
        self._currentPage = currentPage
    }

    var body: some View {
        VStack {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
        }
    }
}
