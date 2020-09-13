//
//  FavoriteHobby.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FavoriteHobby: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var icon: String
    var uesrId: String?
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
