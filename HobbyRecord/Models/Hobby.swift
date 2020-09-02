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
    var contents: String
}

#if DEBUG
let testDatas: [Hobby] = [
    Hobby(date: "9-22-2020", title: "hiking", contents: "ハノン1番"),
    Hobby(date: "9-23-2020", title: "game", contents: "ハノン1番"),
    Hobby(date: "9-24-2020", title: "piano", contents: "ハノン1番"),
    Hobby(date: "9-25-2020", title: "karaoke", contents: "ハノン1番"),
    Hobby(date: "9-26-2020", title: "piano", contents: "ハノン1番"),
    Hobby(date: "9-20-2020", title: "bike", contents: "ハノン1番"),
    Hobby(date: "9-12-2020", title: "photo", contents: "ハノン1番"),
    Hobby(date: "9-2-2020", title: "swimmer", contents: "ハノン1番"),
    Hobby(date: "9-2-2020", title: "volleyball", contents: "ハノン1番"),
    Hobby(date: "9-12-2020", title: "badminton", contents: "ハノン1番"),
    Hobby(date: "9-11-2020", title: "yoga", contents: "ハノン1番"),
    Hobby(date: "10-15-2020", title: "tramp", contents: "ハノン1番"),
    Hobby(date: "10-22-2020", title: "baseball", contents: "ハノン1番"),
    Hobby(date: "10-23-2020", title: "basketball", contents: "ハノン1番"),
    Hobby(date: "10-24-2020", title: "bicycle", contents: "ハノン1番"),
    Hobby(date: "10-25-2020", title: "canvas", contents: "ハノン1番"),
    Hobby(date: "10-26-2020", title: "football", contents: "ハノン1番"),
    Hobby(date: "10-20-2020", title: "bike", contents: "ハノン1番"),
    Hobby(date: "10-12-2020", title: "photo", contents: "ハノン1番"),
    Hobby(date: "10-2-2020", title: "swimmer", contents: "ハノン1番"),
    Hobby(date: "10-2-2020", title: "volleyball", contents: "ハノン1番"),
    Hobby(date: "10-12-2020", title: "swimmer", contents: "ハノン1番"),
    Hobby(date: "10-11-2020", title: "yoga", contents: "ハノン1番"),
    Hobby(date: "10-15-2020", title: "tramp", contents: "ハノン1番")
]
#endif
