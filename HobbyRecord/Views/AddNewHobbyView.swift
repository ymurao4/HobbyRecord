//
//  AddNewHobbyView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct AddNewHobbyView: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var favoriteHobbyVM = FavoriteHobbyViewModel()


    var body: some View {

        VStack(alignment: .leading) {

            Form {

                Section(header: Text("Your Hobby Title")) {

                    TextField("Title", text: $favoriteHobbyVM.title)
                        .padding(5)
                }

                Section(header: Text("Icon")) {

                    IconSetting(icon: $favoriteHobbyVM.icon, kind: K.icons)
                }
            }
            .padding(.top, 10)
        }
        .navigationBarTitle(Text(""),displayMode: .inline)
        .navigationBarItems(trailing:

            Button(action: { self.addRecord() }) {

                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(self.favoriteHobbyVM.isValidate ? Color.orange : Color.gray)
            }
            .disabled(!self.favoriteHobbyVM.isValidate)
        )
    }

    private func addRecord() {

        self.presentationMode.wrappedValue.dismiss()
        self.favoriteHobbyVM.addFavoriteHoby()
    }

}

struct AddHobbyView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewHobbyView()
    }
}

struct IconSetting: View {

    @Binding var icon: String
    var kind: [String]

    var cellHeight: CGFloat {
        calCellHeight()
    }


    var body: some View {

        WaterfallGrid(0..<kind.count, id: \.self) { index in

            Button(action: {

                self.icon = self.kind[index]
            }) {

                ZStack(alignment: .bottom) {

                    Image(self.kind[index])
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.primary.opacity(0.8))
                        .padding(10)

                    if self.icon == self.kind[index] {

                        Rectangle()
                            .frame(width: 25, height: 2.0, alignment: .bottom)
                            .foregroundColor(Color.orange)
                    }
                }
            }
        }
        .gridStyle(columns: 6, spacing: 15)
        .scrollOptions(direction: .vertical, showsIndicators: false)
        .frame(width: UIScreen.main.bounds.width, height: cellHeight)
        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
    }

    private func calCellHeight() -> CGFloat {
        let count = self.kind.count
        let row = count / 6 + 1
        return CGFloat(row * 45)
    }

}

