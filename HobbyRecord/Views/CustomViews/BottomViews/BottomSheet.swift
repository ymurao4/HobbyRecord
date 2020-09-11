//
//  BottomSheet.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct BottomSheet: View {

    @ObservedObject var favoriteHobbyVM: FavoriteHobbyViewModel
    @State var date: Date = Date()
    @Binding var offset: CGFloat

    var body: some View {

        ZStack(alignment: .bottomTrailing) {

            VStack {

                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .cornerRadius(15)
                    .padding()

                VStack {

                    Text("Favorites")
                        .font(.title)
                        .foregroundColor(Color.primary.opacity(0.9))

                    List {

                        ForEach(self.favoriteHobbyVM.favoriteHobbyCellViewModels, id: \.id) { favoriteHobbyCell in

                            HStack {

                                NavigationLink(destination: RecordHobbyView(favoriteHobby: favoriteHobbyCell.favoriteHobby, offset: self.$offset)) {

                                    FavoriteCell(favoriteHobbyCell: favoriteHobbyCell)
                                }
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding(.top, 20)
                .padding()
            }
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(15)

            NavigationLink(destination: AddNewHobbyView()) {

                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.black.opacity(0.9))
                    .padding()
            }
            .frame(width: 50, height: 50)
            .background(Color.orange)
            .cornerRadius(25)
            .padding(.bottom, 140)
            .padding(.trailing, 40)
        }
    }
}


struct FavoriteCell: View {

    var favoriteHobbyCell: FavoriteHobbyCellViewModel

    var body: some View {

        HStack {

            Image(favoriteHobbyCell.favoriteHobby.icon)
                .renderingMode(.template)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.primary.opacity(0.9))
            Text(favoriteHobbyCell.favoriteHobby.title)
                .foregroundColor(Color.primary.opacity(0.9))
        }
        .padding(.horizontal)
    }
}
