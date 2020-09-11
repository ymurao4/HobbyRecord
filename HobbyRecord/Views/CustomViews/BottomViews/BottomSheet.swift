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

                                FavoriteCell(favoriteHobbyCell: favoriteHobbyCell)

                                NavigationLink(destination: RecordHobbyView(favoriteHobby: favoriteHobbyCell.favoriteHobby, offset: self.$offset)) { EmptyView() }
                            }
                        }

                        HStack {

                            Text("Add new one")
                                .foregroundColor(Color.primary.opacity(0.9))
                                .padding()
                                .frame(width: UIScreen.main.bounds.width * 0.9)
                                .background(Color.orange.opacity(0.5))
                                .cornerRadius(20)

                            NavigationLink(destination: AddNewHobbyView()) { EmptyView() }
                        }
                        .padding(.top, 5)
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding(.top, 20)
                .padding()
            }
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(15)
    }
}

struct FavoriteCell: View {

    var favoriteHobbyCell: FavoriteHobbyCellViewModel

    var body: some View {

        HStack {

            Image(favoriteHobbyCell.favoriteHobby.icon)
                .resizable()
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.primary.opacity(0.9))
            Text(favoriteHobbyCell.favoriteHobby.title)
                .foregroundColor(Color.primary.opacity(0.9))
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(20)
    }
}
