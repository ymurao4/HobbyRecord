//
//  title.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/01.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

struct Hobby: Identifiable {
    var id: String = UUID().uuidString
    var date: String
    var title: String
    var detail: String
    var icon: String?
}

#if DEBUG
let testDatas: [Hobby] = [
    Hobby(date: "9/22/2020", title: "hiking", detail: "ハノン1番", icon: "hiking"),
    Hobby(date: "9/23/2020", title: "game", detail: "ハノン1番", icon: "game"),
    Hobby(date: "9/24/2020", title: "piano", detail: "ハノン1番", icon: "piano"),
    Hobby(date: "9/25/2020", title: "karaoke", detail: "ハノン1番", icon: "karaoke"),
    Hobby(date: "9/26/2020", title: "piano", detail: "ハノン1番", icon: "piano"),
    Hobby(date: "9/20/2020", title: "bike", detail: "ハノン1番", icon: "bike"),
    Hobby(date: "9/12/2020", title: "photo", detail: "ハノン1番", icon: "photo"),
    Hobby(date: "9/2/2020", title: "swimmer", detail: "ハノン1番", icon: "swimmer"),
    Hobby(date: "9/2/2020", title: "volleyball", detail: "ハノン1番", icon: "volleyball"),
    Hobby(date: "9/12/2020", title: "badminton", detail: "ハノン1番", icon: "badminton"),
    Hobby(date: "9/11/2020", title: "yoga", detail: "ハノン1番", icon: "yoga"),
    Hobby(date: "10/15/2020", title: "tramp", detail: "ハノン1番", icon: "tramp"),
    Hobby(date: "10/22/2020", title: "baseball", detail: "ハノン1番", icon: "baseball"),
    Hobby(date: "10/23/2020", title: "basketball", detail: "ハノン1番", icon: "basketball"),
    Hobby(date: "10/24/2020", title: "bicycle", detail: "ハノン1番", icon: "bicycle"),
    Hobby(date: "10/25/2020", title: "canvas", detail: "ハノン1番", icon: "canvas"),
    Hobby(date: "10/26/2020", title: "football", detail: "ハノン1番", icon: "football"),
    Hobby(date: "10/20/2020", title: "bike", detail: "ハノン1番", icon: "bike"),
    Hobby(date: "10/12/2020", title: "photo", detail: "ハノン1番", icon: "photo"),
    Hobby(date: "10/2/2020", title: "swimmer", detail: "ハノン1番", icon: "swimmer"),
    Hobby(date: "10/2/2020", title: "volleyball", detail: "ハノン1番", icon: "volleyball"),
    Hobby(date: "10/12/2020", title: "swimmer", detail: "ハノン1番", icon: "swimmer"),
    Hobby(date: "10/11/2020", title: "yoga", detail: "ハノン1番", icon: "yoga"),
    Hobby(date: "10/15/2020", title: "tramp", detail: "ハノン1番", icon: "tramp")
]
#endif
