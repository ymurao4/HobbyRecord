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

            List {

                ForEach(historyVM.hobbies, id: \.self) { hobby in

                    HStack(alignment: .top, spacing: 20) {

                        Text(hobby.date)

                        VStack(alignment: .leading) {

                            ForEach(hobby.details, id: \.self) { detail in

                                Text(detail)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarItems(
            trailing: trailingItem(fav: fav)
        )
        .onAppear {

            self.historyVM.filterRecord(title: fav.title)
        }
    }
}

struct trailingItem: View {

    var fav: FavoriteHobby

    var body: some View {

        HStack(alignment: .center) {

            Image(fav.icon)
                .renderingMode(.template)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.pr(9))

            Text(fav.title)
                .foregroundColor(Color.pr(9))
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.trailing, 40)
    }
}
