//
//  FavoriteHobby.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

struct FavoriteHobby: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var icon: String
}

#if DEBUG
let testDataFavHobbies: [FavoriteHobby] = [
    FavoriteHobby(title: "スマブラ", icon: "game"),
    FavoriteHobby(title: "ピアノ", icon: "piano"),
    FavoriteHobby(title: "ハイキング", icon: "hiking"),
    FavoriteHobby(title: "個人開発", icon: "swift"),
    FavoriteHobby(title: "家で動画鑑賞をする日", icon: "youtube"),
]
#endif
