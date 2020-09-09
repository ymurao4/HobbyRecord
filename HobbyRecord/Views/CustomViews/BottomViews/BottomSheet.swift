//
//  BottomSheet.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct BottomSheet: View {

    @State var date: Date = Date()

    private var favoriteHobbies: [Hobby] = [
        Hobby(date: "", title: "ピアノ", details: [""], icon: "piano"),
        Hobby(date: "", title: "ハイキング", details: [""], icon: "hiking"),
        Hobby(date: "", title: "トランプ", details: [""], icon: "tramp"),
        Hobby(date: "", title: "スマブラ", details: [""], icon: "game")
    ]

    var body: some View {

        VStack {

            VStack {

                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .cornerRadius(15)
                    .padding()

                Text("Favorite Hobby")
                    .font(.title)
                    .foregroundColor(Color.primary.opacity(0.9))

                ScrollView(.vertical, showsIndicators: false) {

                    // お気に入りのHobbyを追加するやつ
                    VStack {

                        ForEach(favoriteHobbies, id: \.id) { hobby in

                            Button(action: {
                                print(hobby.title)
                            }) {

                                HStack {

                                    Image(hobby.icon)
                                        .resizable()
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color.primary.opacity(0.9))
                                    Text(hobby.title)
                                        .foregroundColor(Color.primary.opacity(0.9))
                                }
                            }
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.9)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(20)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .padding()
                    .padding(.top)
                }
            }
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(15)
        }
    }
}
