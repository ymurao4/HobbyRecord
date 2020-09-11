//
//  ContentVIew.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var hobbyVM = HobbyViewModel()
    @ObservedObject var favoriteHobbyVM = FavoriteHobbyViewModel()
    @State var isActionSheet: Bool = false
    @State var isDetailView: Bool = false

    var clManager = CLManager(
        calendar: Calendar.current,
        minmumDate: Date(),
        maximumDate: Date().addingTimeInterval(60*60*24*365))

    private var cellWidth: CGFloat {

        calculateCellWidth()
    }

    var body: some View {

        NavigationView {

            ZStack(alignment: .bottom) {

                VStack {

                    CustomNavbar(isActionSheet: $isActionSheet, clManager: clManager, cellWidth: cellWidth)
                    CalendarView(hobbyVM: hobbyVM, isDetailView: $isDetailView, clManager: clManager, cellWidth: cellWidth)
                }
                .edgesIgnoringSafeArea(.top)

                GeometryReader{ reader in

                    ReaderView(favoriteHobbyVM: self.favoriteHobbyVM, reader: reader)
                        .edgesIgnoringSafeArea(.all)
                }

                VStack {

                    Spacer()

                    CustomActionSheet(isActionSheet: $isActionSheet)
                        .offset(y: self.isActionSheet ? 0 : UIScreen.main.bounds.height)
                }
                .background((isActionSheet ? Color.black.opacity(0.3) : Color.clear)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {

                    self.isActionSheet.toggle()
                    }
                )
                    .edgesIgnoringSafeArea(.bottom)

                VStack {

                    if isDetailView {

                        Spacer()
                        DateView(clManager: self.clManager, hobbyVM: self.hobbyVM)
                            .offset(y: isDetailView ? 0 : UIScreen.main.bounds.height)
                        Spacer()
                    }
                }
                .padding(.top, 60)
                .padding(.bottom, 20)
                .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                .background((isDetailView ? Color.black.opacity(0.3) : Color.clear)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {

                    self.clManager.selectedDate = nil
                    self.isDetailView.toggle()
                })
                    .edgesIgnoringSafeArea(.all)

            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .animation(.default)
        }
        .accentColor(Color.orange)
    }

    private func calculateCellWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width
        return width / 7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



