//
//  title.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/01.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Hobby: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var date: String
    var title: String
    var details: [String]
    var icon: String
    var uesrId: String?
}

#if DEBUG
let testDataHobbies: [Hobby] = [
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

]
#endif
