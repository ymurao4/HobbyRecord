//
//  AddNewHobbyViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class FavoriteHobbyViewModel: ObservableObject {

    @Published var favoriteHobbyCellViewModels = [FavoriteHobbyCellViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        self.favoriteHobbyCellViewModels = testDataFavHobbies.map { favHobby in
            FavoriteHobbyCellViewModel(favHobby: favHobby)
        }
    }

}
