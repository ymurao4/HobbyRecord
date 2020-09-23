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
    @ObservedObject var hobbyVM: HobbyViewModel
    @Binding var selectedDate: Date
    
    @Binding var isDetailView: Bool

    private var month: DateInterval {
        return calendar.dateInterval(of: .month, for: calendarVM.date)!
    }

    var body: some View {

        VStack {

            CalendarView(interval: month, calendarVM: calendarVM) { date in

                DateCellView(hobbyVM: hobbyVM, isDetailView: $isDetailView, selectedDate: $selectedDate, date: date)
            }

            Spacer()
        }
        .padding(.top, 10)
    }
}

struct DateCellView: View {

    @ObservedObject var hobbyVM: HobbyViewModel
    @Binding var isDetailView: Bool
    @Binding var selectedDate: Date

    var date: Date
    var hobbies: [Hobby] {

        getHobbies()
    }

    var body: some View {

        ZStack {

            VStack(spacing: 5) {

                Text(DateFormatter.stringDate.string(from: date))
                    .foregroundColor(Color.pr(9))

                if hobbies.count != 0 {

                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 5) {

                        ForEach(hobbies) { hobby in

                            Image(hobby.icon)
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                    }
                    .padding(.horizontal, 7)
                }

                Spacer()
            }
            .padding(.top, 5)
            .frame(minWidth: self.cellWidth(), maxWidth: self.cellWidth(), minHeight: self.cellWidth() * 1.6, maxHeight: self.cellWidth() * 1.8)

            EdgeBorder(width: 0.5, edge: .top)
                .foregroundColor(Color.gray.opacity(0.4))
        }
        .onTapGesture {

            self.selectedDate = date
            self.isDetailView = true
        }
    }

    private func cellWidth() -> CGFloat {

        let width = UIScreen.main.bounds.width
        return width / 7
    }

    private func getHobbies() -> [Hobby] {

        var hobbies: [Hobby] = []

        for hobbyCellVM in self.hobbyVM.hobbyCellViewModels {
            let stringDate = hobbyCellVM.hobby.date
            if  stringDate == D.formatter.string(from: date) {

                if hobbies.count <= 5 {

                    hobbies.append(hobbyCellVM.hobby)
                }
            }
        }

        return hobbies
    }
}

struct CalendarView<DateView>: View where DateView: View {

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


