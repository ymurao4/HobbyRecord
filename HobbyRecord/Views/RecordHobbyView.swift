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

    var body: some View {

        VStack(alignment: .leading) {

            ZStack(alignment: .bottom) {

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
                        .onDelete(perform: rowRemove)

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

                Button(action: {

                    self.isAlert.toggle()
                }) {

                    HStack {

                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 20, height: 20)

                        Text("Delete".localized)
                            .foregroundColor(.white)
                    }
                    .padding(EdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 30))
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(30)
                }
            }

        }
        .alert(isPresented: $isAlert) {

            alertView()
        }
        .navigationBarTitle(Text(""),displayMode: .inline)
        .navigationBarItems(trailing:

            CustomNavigationbarTitle(hobbyVM: hobbyVM, detailVM: detailVM, date: $date, offset: $offset, favoriteHobby: favoriteHobby)
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

    private func rowRemove(offsets: IndexSet) {

        self.detailVM.removeRow(offsets: offsets)
    }
}


struct CustomNavigationbarTitle: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var hobbyVM: HobbyViewModel
    @ObservedObject var detailVM: DetailViewModel
    @Binding var date: Date
    @Binding var offset: CGFloat
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

            Button(action: {

                self.addRecord()
            }) {

                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.orange)
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
