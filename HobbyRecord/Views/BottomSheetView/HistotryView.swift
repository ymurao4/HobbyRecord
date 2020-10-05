//
//  HistotryView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/10/05.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct HistotryView: View {

    @ObservedObject var historyVM = HistoryViewModel()
    var fav: FavoriteHobby

    var body: some View {

        VStack {

            Text(fav.title)
            Text(fav.icon)
        }
    }
}

struct HistotryView_Previews: PreviewProvider {
    static var previews: some View {
        HistotryView(fav: FavoriteHobby(title: "", icon: "", uesrId: ""))
    }
}
