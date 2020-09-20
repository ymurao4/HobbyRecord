//
//  AddNewHobbyView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct AddNewHobbyView: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var favoriteHobbyVM: FavoriteHobbyViewModel

    var body: some View {

        VStack(alignment: .leading) {

            Form {

                Section(header: Text("title".localized)) {

                     TextField("Title".localized, text: $favoriteHobbyVM.title)
                }

                Section(header: Text("Icon".localized)) {

                    IconSetting(icon: $favoriteHobbyVM.icon, kind: K.icons)
                }
            }
            .padding(.top, 10)
        }
        .navigationBarTitle(Text(""),displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarItems(trailing:

            Button(action: { self.addRecord() }) {

                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(self.favoriteHobbyVM.isValidate ? Color.orange : Color.gray.opacity(0.3))
            }
            .disabled(!self.favoriteHobbyVM.isValidate)
        )
    }

    private func addRecord() {

        self.presentationMode.wrappedValue.dismiss()
        self.favoriteHobbyVM.addFavoriteHobby()
    }
}

