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
    var favoriteHobby: FavoriteHobby

    var body: some View {

        VStack {

            ScrollView(.vertical, showsIndicators: false) {

                VStack {

                    Text(self.favoriteHobby.title)
                    Text(self.favoriteHobby.icon)
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding(.top, 20)
            }
        }
        .navigationBarTitle(Text(""),displayMode: .inline)
        .navigationBarItems(trailing:

            HStack(alignment: .center) {

                Image(self.favoriteHobby.icon)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)

                Text(self.favoriteHobby.title)
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding(.trailing, 40)
        )
    }
}

struct RecordHobbyVIew_Previews: PreviewProvider {
    static var previews: some View {
        RecordHobbyView(favoriteHobby: FavoriteHobby(title: "", icon: ""))
    }
}
