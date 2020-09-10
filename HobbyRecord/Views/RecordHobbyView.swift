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

            ZStack {

                HStack {

                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .padding()
                    }

                    Spacer()
                }

                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .cornerRadius(15)
                    .padding()
            }

            ScrollView(.vertical, showsIndicators: false) {

                VStack {

                    Text(favoriteHobby.title)
                    Text(favoriteHobby.icon)
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding(.top, 20)
            }
        }
        .background(BlurView(style: .systemMaterial))
        .padding(.horizontal)
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)
    }
}

struct RecordHobbyVIew_Previews: PreviewProvider {
    static var previews: some View {
        RecordHobbyView(favoriteHobby: FavoriteHobby(title: "", icon: ""))
    }
}
