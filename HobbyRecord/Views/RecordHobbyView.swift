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
    var favoriteHobby: FavoriteHobby
    @Binding var offset: CGFloat
    @State var date: Date = Date()
    @State private var isAlert: Bool = false
    @State var isActionSheet: Bool = false

    var body: some View {

        ZStack(alignment: .bottom) {

            VStack(alignment: .leading) {

                Form {

                    Section(header: Text("Date".localized)) {

                        DatePicker(selection: $date, displayedComponents: .date) {

                            Text("Select Date".localized)
                                .foregroundColor(Color.primary)
                        }
                    }

                    Section(header: Text("Detail".localized)) {

                        ForEach(detailVM.detailCellViewModels) { detailCell in

                            DetailCell(detailCellVM: detailCell)
                        }

                        Button(action: { self.detailVM.addDetail(detail: Detail(detail: "")) }) {

                            HStack {

                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Add New Detail".localized)
                            }
                            .foregroundColor(Color.orange)
                        }
                    }
                }
            }
            .padding(.horizontal)
            VStack {

                Spacer()

                ActionSheetView(isActionSheet: $isActionSheet, isAlert: $isAlert)
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

            CustomNavigationbarTitle(hobbyVM: hobbyVM, detailVM: detailVM, date: $date, offset: $offset, isActionSheet: $isActionSheet, favoriteHobby: favoriteHobby)
        )
    }

    private func alertView() -> Alert {

        Alert(

            title: Text("Are you sure?".localized),
            message: Text("Do you want to delete this hobby from favorites?".localized),
            primaryButton: .cancel(),
            secondaryButton: .destructive(Text("Delete"), action: {

                self.favoriteHobbyVM.removeFavoriteHobby(fav: self.favoriteHobby)
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
    var favoriteHobby: FavoriteHobby
    private var title: String {

        favoriteHobby.title
    }
    private var icon: String {

        favoriteHobby.icon
    }

    var body: some View {

        ZStack(alignment: .trailing) {

            HStack(alignment: .center) {

                Image(self.favoriteHobby.icon)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.pr(9))

                Text(self.favoriteHobby.title)
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
        hobbyVM.addRecord(hobby: Hobby(date: D.formatter.string(from: date), title: title, details: detailVM.details, icon: icon))
        // bottomSheetを下げる
        offset = 0
        presentationMode.wrappedValue.dismiss()
    }
}


struct DetailCell: View {

    @ObservedObject var detailCellVM: DetailCellViewModel

    var body: some View {

        // SwiftUIのTextFieldは日本語入力に不具合があるので、UIViewRepresentableから利用
        // TextField("", text: $detailCellVM.detail.detail)
        _TextField(title: "", text: $detailCellVM.detail.detail)
    }
}


struct ActionSheetView: View {

    @Binding var isActionSheet: Bool
    @Binding var isAlert: Bool

    private let buttons: [String] = ["Edit", "Delete", "Cancel"]

    var body: some View {

        VStack(alignment: .leading, spacing: 15) {

            ForEach(buttons, id: \.self) { button in

                Button(action: {

                    self.switchAction(text: button)
                }) {

                    HStack {

                        Text(button.localized)
                        Spacer()
                    }
                    .foregroundColor(.orange)
                    .padding(.vertical, 3)
                    .padding(.horizontal)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.top, 20)
        .padding(.horizontal)
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(25)
    }

    private func switchAction(text: String) {

        switch text {
        case "Edit":
            print("Edit")
        case "Delete":
            self.isAlert = true
        case "Cancel":
            self.isActionSheet = false
        default:
            return
        }
    }
}
