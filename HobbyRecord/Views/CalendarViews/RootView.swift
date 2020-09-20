//
//  RootView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct RootView: View {

    @Environment(\.calendar) var calendar
    @ObservedObject var calendarVM = CalendarViewModel()

    private var month: DateInterval {
        return calendar.dateInterval(of: .month, for: calendarVM.date)!
    }

    var body: some View {

        VStack {

            NewCalendarView(interval: month, calendarVM: calendarVM) { date in

                Text(DateFormatter.stringDate.string(from: date))
                    .cornerRadius(8)
                    .frame(width: self.cellWidth(), height: self.cellWidth() * 1.8)
            }

            Spacer()
        }
    }

    private func cellWidth() -> CGFloat {

        let width = UIScreen.main.bounds.width
        return width / 7
    }
}

struct NewCalendarView<DateView>: View where DateView: View {

    @Environment(\.calendar) var calendar
    @ObservedObject var calendarVM: CalendarViewModel

    let interval: DateInterval
    let showHeaders: Bool
    let content: (Date) -> DateView

    init(
        interval: DateInterval,
        calendarVM: CalendarViewModel,
        showHeaders: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.interval = interval
        self.calendarVM = calendarVM
        self.showHeaders = showHeaders
        self.content = content
    }

    var body: some View {

        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 0) {

            ForEach(months, id: \.self) { month in

                Section(header: header(for: month)) {

                    ForEach(days(for: month), id: \.self) { date in

                        HStack(spacing: 0) {

//                            if calendar.isDate(date, equalTo: month, toGranularity: .month) {

                                content(date).id(date)
//                            } else {
//
//                                content(date).hidden()
//                            }
                        }
                    }
                }
            }
        }
    }

    private func header(for month: Date) -> some View {

//        let component = calendar.component(.month, from: month)
//        let formatter = component == 1 ? DateFormatter.monthAndYear : .month
        let formatter = DateFormatter.monthAndYear

        return Group {

            if showHeaders {

                HStack {

                    Button(action: { self.calendarVM.prevMonth() }) {

                        Image(systemName: "chevron.compact.left")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(Color.orange)
                                .padding()
                    }

                    Text(formatter.string(from: month))
                        .font(.title)
                        .padding()

                    Button(action: { self.calendarVM.nextMonth() }) {

                        Image(systemName: "chevron.compact.right")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(Color.orange)
                                .padding()
                    }
                }
            }
        }
    }

    private var months: [Date] {

        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    private func days(for month: Date) -> [Date] {

        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }

        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
}



fileprivate extension DateFormatter {
    
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }

    static var stringDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        formatter.locale = .current
        formatter.dateFormat = "d"
        return formatter
    }
}

extension Calendar {

    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}


