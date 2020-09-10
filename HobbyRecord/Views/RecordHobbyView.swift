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
    var favoriteHobby: FavoriteHobby

    var body: some View {

        VStack {

            ScrollView(.vertical, showsIndicators: false) {

                VStack {

                    Text(favoriteHobby.title)
                    Text(favoriteHobby.icon)
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding(.top, 20)
            }
        }
        .navigationBarTitle(Text(""),displayMode: .inline)
        .padding(.horizontal)
    }
}

struct RecordHobbyVIew_Previews: PreviewProvider {
    static var previews: some View {
        RecordHobbyView(favoriteHobby: FavoriteHobby(title: "", icon: ""))
    }
}
