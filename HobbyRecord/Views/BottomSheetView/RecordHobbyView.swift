//
//  RecordHobbyVIew.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct RecordHobbyView: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var hobbyVM = HobbyViewModel()
    @ObservedObject var detailVM = DetailViewModel()
    @ObservedObject var favoriteHobbyVM: FavoriteHobbyViewModel
    @ObservedObject var favoriteHobbyCellVM: FavoriteHobbyCellViewModel
    @Binding var offset: CGFloat
    @State var date: Date = Date()
    @State var isAlert: Bool = false
    @State var isActionSheet: Bool = false
    // 下記バグの対応策
    @State var text: String = ""

    var body: some View {

        ZStack(alignment: .bottom) {

            VStack(alignment: .leading) {

                Form {

                    Section(header: Text("Date".localized)) {

                        DatePicker(selection: $date, displayedComponents: .date) {

                            Text("Select Date".localized)
                        }
                    }

                    //ios14からcellが消える
//                    Section(header: Text("Detail".localized)) {
//
//                        ForEach(detailVM.detailCellViewModels) { detailCell in
//
//                            DetailCell(detailCellVM: detailCell)
//                        }
//                        .onDelete(perform: rowRemove)
//
//                        Button(action: {
//
//                            self.detailVM.addDetail(detail: Detail(detail: ""))
//                        }) {
//
//                            HStack {
//
//                                Image(systemName: "plus.circle.fill")
//                                    .resizable()
//                                    .frame(width: 20, height: 20)
//
//                                Text("Add New Detail".localized)
//                            }
//                            .foregroundColor(Color.orange)
//                        }
//                    }
                    Section(header: Text("Detail".localized)) {

                        TextField("", text: $text)
                    }
                }
            }
            .padding(.horizontal)
            
            VStack {

                Spacer()

                ActionSheetView(isActionSheet: $isActionSheet, isAlert: $isAlert, favoriteHobbyVM: favoriteHobbyVM, favoriteHobby: favoriteHobbyCellVM.favoriteHobby)
                    .offset(y: self.isActionSheet ? 0 : UIScreen.main.bounds.height)
            }
            .background((isActionSheet ? Color.bl(3) : Color.clear)
                            .edgesIgnoringSafeArea(.bottom)
                            .onTapGesture {

                                self.isActionSheet.toggle()
                            }
            )
        }
        .edgesIgnoringSafeArea(.bottom)
        .animation(.spring())
        .alert(isPresented: $isAlert) {

            alertView()
        }
        .navigationBarTitle(Text(""),displayMode: .inline)
        .navigationBarItems(trailing:

                                CustomNavigationbarTitle(hobbyVM: hobbyVM, detailVM: detailVM, date: $date, offset: $offset, isActionSheet: $isActionSheet, text: $text, favoriteHobbyVM: favoriteHobbyVM)
        )
    }

    private func rowRemove(offsets: IndexSet) {

        self.detailVM.removeRow(offsets: offsets)
    }

    private func alertView() -> Alert {

        Alert(

            title: Text("Are you sure?".localized),
            message: Text("Do you want to delete this hobby from favorites?".localized),
            primaryButton: .cancel(),
            secondaryButton: .destructive(Text("Delete"), action: {

                self.favoriteHobbyVM.removeFavoriteHobby(fav: self.favoriteHobbyCellVM.favoriteHobby)
                self.presentationMode.wrappedValue.dismiss()
            })
        )
    }
}


struct CustomNavigationbarTitle: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var hobbyVM: HobbyViewModel
    @ObservedObject var detailVM: DetailViewModel
    @Binding var date: Date
    @Binding var offset: CGFloat
    @Binding var isActionSheet: Bool
    @Binding var text: String
    @ObservedObject var favoriteHobbyVM: FavoriteHobbyViewModel

    var body: some View {

        ZStack(alignment: .trailing) {

            HStack(alignment: .center) {

                Image(favoriteHobbyVM.icon)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.pr(9))

                Text(favoriteHobbyVM.title)
                    .foregroundColor(Color.pr(9))
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding(.trailing, 40)

            HStack {

                Button(action: {

                    self.isActionSheet.toggle()
                }) {

                    Image("open-menu")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.orange)
                }
                .padding(.trailing, 15)

                Button(action: {

                    self.addRecord()
                }) {

                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.orange)
                }
            }
            .padding(.trailing, 60)
        }
    }

    private func addRecord() {

        detailVM.addAllDetailsToArray()
//        hobbyVM.addRecord(hobby: Hobby(date: D.formatter.string(from: date), title: favoriteHobbyVM.title, details: detailVM.details, icon: favoriteHobbyVM.icon))
        hobbyVM.addRecord(hobby: Hobby(date: D.formatter.string(from: date), title: favoriteHobbyVM.title, details: [text], icon: favoriteHobbyVM.icon))
        // bottomSheetを下げる
        offset = 0
        presentationMode.wrappedValue.dismiss()
    }
}


struct ActionSheetView: View {

    @Binding var isActionSheet: Bool
    @Binding var isAlert: Bool
    @ObservedObject var favoriteHobbyVM: FavoriteHobbyViewModel
    var favoriteHobby: FavoriteHobby

    var body: some View {

        VStack(alignment: .leading, spacing: 15) {

            VStack(spacing: 10) {

                VStack {

                    NavigationLink(destination: HistotryView(fav: favoriteHobby)) {

                        HStack {

                            Text("History".localized)
                                .bold()
                                .padding(.vertical, 7)
                            Spacer()
                        }
                    }
                    .simultaneousGesture(TapGesture().onEnded {

                        self.isActionSheet = false
                    })
                }

                VStack {

                    NavigationLink(destination: UpdateNewHobbyView(favoriteHobbyVM: favoriteHobbyVM, favoriteHobby: favoriteHobby, oldTitle: favoriteHobbyVM.title, oldIcon: favoriteHobbyVM.icon)) {

                        HStack {

                            Text("Edit".localized)
                                .bold()
                                .padding(.vertical, 7)
                            Spacer()
                        }
                    }
                    .simultaneousGesture(TapGesture().onEnded {

                        self.favoriteHobbyVM.title = self.favoriteHobby.title
                        self.favoriteHobbyVM.icon = self.favoriteHobby.icon
                        self.isActionSheet = false
                    })
                }

                Divider()

                Button(action: {

                    self.isAlert = true
                    self.isActionSheet = false
                }) {

                    HStack {

                        Text("Delete".localized)
                            .bold()
                            .padding(.vertical, 7)
                        Spacer()
                    }
                }
            }
            .foregroundColor(.orange)
            .padding(.horizontal)
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.top, 20)
        .padding(.horizontal)
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(25)
    }
}


