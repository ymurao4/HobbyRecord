//
//  RecordHobbyVIew.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct RecordHobbyView: View {

    @ObservedObject var hobbyVM = HobbyViewModel()
    @ObservedObject var detailVM = DetailViewModel()
    var favoriteHobby: FavoriteHobby
    @Binding var offset: CGFloat
    @State var date: Date = Date()

    var body: some View {

        VStack(alignment: .leading) {

            Form {

                Section(header: Text("Select Date")) {

                    DatePicker(selection: $date, displayedComponents: .date) {

                        Text("Select Date")
                            .foregroundColor(Color.primary)
                    }
                }

                Section(header: Text("Detail")) {

                    ForEach(detailVM.detailCellViewModels) { detailCell in

                        DetailCell(detailCellVM: detailCell)
                    }
                    .onDelete(perform: rowRemove)

                    Button(action: { self.detailVM.addDetail(detail: Detail(detail: "")) }) {

                        HStack {

                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Add New Detail")
                        }
                        .foregroundColor(Color.orange)
                    }
                }
            }

        }
        .navigationBarTitle(Text(""),displayMode: .inline)
        .navigationBarItems(trailing:

            CustomNavigationbarTitle(hobbyVM: hobbyVM, detailVM: detailVM, date: $date, offset: $offset, favoriteHobby: favoriteHobby)
        )
    }


    private func rowRemove(offsets: IndexSet) {

        self.detailVM.removeRow(offsets: offsets)
    }
}

struct RecordHobbyVIew_Previews: PreviewProvider {
    static var previews: some View {
        RecordHobbyView(favoriteHobby: FavoriteHobby(title: "", icon: ""), offset: .constant(0))
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

        TextField("", text: $detailCellVM.detail.detail)
    }
}
