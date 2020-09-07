//
//  title.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/01.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

struct Hobby: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var date: String
    var title: String
    var details: [String]
    var icon: String
}

#if DEBUG
let testDatas: [Hobby] = [
    Hobby(date: "9/22/2020", title: "ハイキング", details: ["ハノン一番"], icon: ""),
    Hobby(date: "9/23/2020", title: "ゲーム", details: ["ハノン一番"], icon: "game"),
    Hobby(date: "9/24/2020", title: "piano", details: ["ハノン1番"], icon: "piano"),
    Hobby(date: "9/25/2020", title: "karaoke", details: ["ハノン1番"], icon: "karaoke"),
    Hobby(date: "9/26/2020", title: "piano", details: ["ハノン1番"], icon: "piano"),
    Hobby(date: "9/20/2020", title: "bike", details: ["ハノン1番"], icon: "bike"),
    Hobby(date: "9/12/2020", title: "photo", details: ["ハノン1番"], icon: "photo"),
    Hobby(date: "9/2/2020", title: "swimmer", details: ["ハノン1番"], icon: "swimmer"),
    Hobby(date: "9/2/2020", title: "volleyball", details: ["ハノン1番"], icon: "volleyball"),
    Hobby(date: "9/12/2020", title: "badminton", details: ["ハノン1番"], icon: "badminton"),
    Hobby(date: "9/11/2020", title: "yoga", details: ["ハノン1番"], icon: "yoga"),
    Hobby(date: "10/15/2020", title: "tramp", details: ["ハノン1番"], icon: "tramp"),
    Hobby(date: "10/22/2020", title: "baseball", details: ["ハノン1番"], icon: "baseball"),
    Hobby(date: "10/23/2020", title: "basketball", details: ["ハノン1番"], icon: "basketball"),
    Hobby(date: "10/24/2020", title: "bicycle", details: ["ハノン1番"], icon: "bicycle"),
    Hobby(date: "10/25/2020", title: "canvas", details: ["ハノン1番"], icon: "canvas"),
    Hobby(date: "10/26/2020", title: "football", details: ["ハノン1番"], icon: "football"),
    Hobby(date: "10/20/2020", title: "bike", details: ["ハノン1番"], icon: "bike"),
    Hobby(date: "10/12/2020", title: "photo", details: ["ハノン1番"], icon: "photo"),
    Hobby(date: "10/2/2020", title: "水泳", details: ["ハノン1番"], icon: "swimmer"),
    Hobby(date: "10/2/2020", title: "バレー", details: ["ハノン1番"], icon: "volleyball"),
    Hobby(date: "10/12/2020", title: "swimmer", details: ["ハノン1番"], icon: "swimmer"),
    Hobby(date: "10/11/2020", title: "yoga", details: ["ハノン1番"], icon: "yoga"),
    Hobby(date: "10/15/2020", title: "tramp", details: ["ハノン1番"], icon: "tramp"),
    Hobby(date: "11/20/2020", title: "bike", details: ["ハノン1番"], icon: "bike"),
    Hobby(date: "11/12/2020", title: "photo", details: ["ハノン1番"], icon: "photo"),
    Hobby(date: "11/2/2020", title: "swimmer", details: ["ハノン1番"], icon: "swimmer"),
    Hobby(date: "11/2/2020", title: "volleyball", details: ["ハノン1番"], icon: "volleyball"),
    Hobby(date: "11/12/2020", title: "badminton", details: ["ハノン1番"], icon: "badminton"),
    Hobby(date: "11/11/2020", title: "yoga", details: ["ハノン1番"], icon: "c#"),
    Hobby(date: "12/15/2020", title: "tramp", details: ["ハノン1番"], icon: "c++"),
    Hobby(date: "12/22/2020", title: "baseball", details: ["ハノン1番"], icon: "book"),
    Hobby(date: "12/23/2020", title: "basketball", details: ["ハノン1番"], icon: "css"),
    Hobby(date: "12/24/2020", title: "bicycle", details: ["ハノン1番"], icon: "flute"),
    Hobby(date: "12/25/2020", title: "canvas", details: ["ハノン1番"], icon: "guitar"),
    Hobby(date: "12/26/2020", title: "football", details: ["ハノン1番"], icon: "html"),
    Hobby(date: "12/20/2020", title: "bike", details: ["ハノン1番"], icon: "java"),
    Hobby(date: "12/12/2020", title: "photo", details: ["ハノン1番"], icon: "js"),
    Hobby(date: "12/2/2020", title: "水泳", details: ["ハノン1番"], icon: "pen"),
    Hobby(date: "12/2/2020", title: "バレー", details: ["ハノン1番"], icon: "php"),
    Hobby(date: "12/12/2020", title: "swimmer", details: ["ハノン1番"], icon: "python"),
    Hobby(date: "12/11/2020", title: "yoga", details: ["ハノン1番"], icon: "twitter"),
    Hobby(date: "12/15/2020", title: "tramp", details: ["ハノン1番"], icon: "webprogramming"),
    Hobby(date: "9/1/2020", title: "instagram", details: ["インスタに投稿したよ"], icon: "instagram"),
    Hobby(date: "9/2/2020", title: "instagram", details: ["インスタに投稿したよ", "動画をアップロードしたよ", "キャンプに行ったよ"], icon: "instagram")
]
#endif
