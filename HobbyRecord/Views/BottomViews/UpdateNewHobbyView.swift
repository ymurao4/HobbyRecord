//
//  UpdateNewHobbyView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/14.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct UpdateNewHobbyView: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var favoriteHobbyVM: FavoriteHobbyViewModel
    var favoriteHobby: FavoriteHobby

    @State private(set) var oldTitle: String
    @State private(set) var oldIcon: String

    var body: some View {

        VStack(alignment: .leading) {

            Form {

                Section(header: Text("title".localized)) {

                     TextField("Title".localized, text: $favoriteHobbyVM.title)
                        .padding(5)
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
        self.favoriteHobbyVM.updateFavoriteHobby(fav: favoriteHobby, title: favoriteHobbyVM.title, icon: favoriteHobbyVM.icon, oldTitle: oldTitle, oldIcon: oldIcon)
    }
}
