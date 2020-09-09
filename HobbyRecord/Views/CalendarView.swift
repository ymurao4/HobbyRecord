//
//  ContentView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/08/28.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct CalendarView: View {

    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var hobbyVM = HobbyViewModel()
    @State private var isDetailView: Bool = false
    @State var isBottomSheet: Bool = false

    // カレンダーの範囲
    var clManager = CLManager(
        calendar: Calendar.current,
        minmumDate: Date(),
        maximumDate: Date().addingTimeInterval(60*60*24*365*2))

    private var cellWidth: CGFloat {
        calculateCellWidth()
    }

    //今日を初期画面に表示するのは、scrollViewReader待ち
    var body: some View {

        ZStack(alignment: .bottom) {

            VStack(spacing: 0) {

                CustomNavbar(isDetailView: self.$isDetailView, isBottomSheet: $isBottomSheet, clManager: self.clManager, cellWidth: cellWidth)
                CLViewController(clManager: self.clManager, hobbyVM: self.hobbyVM, isDetailView: self.$isDetailView)
            }

            GeometryReader{ reader in

                ReaderView(reader: reader)
                    .edgesIgnoringSafeArea(.all)
            }

            if isDetailView {

                DetailView(clManager: self.clManager, hobbyVM: self.hobbyVM)
                    .padding(.bottom, 5)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }

    private func calculateCellWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width
        return width / 7
    }

    private func addButton() -> some View {

        Button(action: {

        }) {

            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.defaultColor(colorScheme: colorScheme))
                .padding()
        }
        .frame(width: 60, height: 60)
        .background(Color.orange)
        .cornerRadius(30)
        .padding(.trailing, 10)
    }

}

struct CustomNavbar: View {

    @Binding var isDetailView: Bool
    @Binding var isBottomSheet: Bool
    var clManager: CLManager
    private let dayOfTheWeek: [String] = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    var cellWidth: CGFloat

    var body: some View {

        VStack(alignment: .trailing) {

            Spacer()

            Button(action: {

                self.isBottomSheet.toggle()
            }) {

                Image("open-menu")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 18)
            }

            HStack(spacing: 0) {

                ForEach(dayOfTheWeek, id: \.self) { row in

                    Text(row.uppercased())
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(self.dayOfTheWeekColor(row: row))
                        .frame(width: self.cellWidth, height: 20)
                }
            }
            .padding(.bottom, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: 110)
        .background(Color(UIColor.systemGray6).opacity(0.9))
        .onTapGesture {
            withAnimation {
                self.clManager.selectedDate = nil
                self.isDetailView = false
            }
        }
    }

    private func dayOfTheWeekColor(row: String) -> Color {
        switch row {
        case "sun":
            return Color.red
        case "sat":
            return Color.blue
        default:
            return Color.primary.opacity(0.9)
        }
    }
}


struct ReaderView: View {

    @State var offset: CGFloat = 0
    var reader: GeometryProxy

    var body: some View {

        VStack {

            BottomSheet()
                .offset(y: reader.frame(in: .global).height)
                .offset(y: self.offset)
                .gesture(DragGesture()
                    .onChanged({ (value) in

                        withAnimation {

                            // checking the direction of scroll
                            if value.startLocation.y > self.reader.frame(in: .global).midX {

                                if value.translation.height < 0 && self.offset > (-self.reader.frame(in: .global).height + 150) {

                                    self.offset = value.translation.height
                                }
                            }

                            if value.startLocation.y < self.reader.frame(in: .global).midX {

                                if value.startLocation.y < self.reader.frame(in: .global).midX {

                                    if value.translation.height > 0 && self.offset < 0 {

                                        self.offset = (-self.reader.frame(in: .global).height + 150) + value.translation.height
                                    }
                                }
                            }
                        }
                    })
                    .onEnded({ (value) in

                        withAnimation {

                            if value.startLocation.y > self.reader.frame(in: .global).midX {

                                if -value.translation.height > self.reader.frame(in: .global).midX {

                                    self.offset = (-self.reader.frame(in: .global).height + 150)
                                    return
                                }

                                self.offset = 0
                            }

                            if value.startLocation.y < self.reader.frame(in: .global).midX {

                                if value.translation.height < self.reader.frame(in: .global).midX {

                                    self.offset = (-self.reader.frame(in: .global).height + 150)
                                    return
                                }

                                self.offset = 0
                            }
                        }
                    }))

        }
    }
}
