//
//  AddNewHobbyCellViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Combine

class FavoriteHobbyCellViewModel: ObservableObject {

    @Published var favoriteHobby: FavoriteHobby
    var id: String = ""
    private var cancellable = Set<AnyCancellable>()

    init(favHobby: FavoriteHobby) {

        self.favoriteHobby = favHobby

        $favoriteHobby.map { favHobby in
            favHobby.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellable)
    }
}
