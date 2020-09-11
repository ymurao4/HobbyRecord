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

    @Published var favoriteHobbyCellViewModels: [FavoriteHobbyCellViewModel] = []
    @Published var isValidate: Bool = false
    @Published var title: String = ""
    @Published var icon: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        self.favoriteHobbyCellViewModels = testDataFavHobbies.map { favHobby in
            FavoriteHobbyCellViewModel(favHobby: favHobby)
        }

        Publishers.CombineLatest($title, $icon).map { (title, icon) -> Bool in

            let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)

            if trimmedTitle != "" && icon != "" {
                return true
            } else {
                return false
            }
        }
        .eraseToAnyPublisher()
        .assign(to: \.isValidate, on: self)
        .store(in: &cancellables)

    }

    func addFavoriteHoby() {

        let favoriteHobbyCellVM = FavoriteHobbyCellViewModel(favHobby: FavoriteHobby(title: title, icon: icon))
        self.favoriteHobbyCellViewModels.append(favoriteHobbyCellVM)
    }
}
