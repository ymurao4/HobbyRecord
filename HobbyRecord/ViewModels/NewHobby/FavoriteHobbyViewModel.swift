//
//  AddNewHobbyViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FavoriteHobbyViewModel: ObservableObject {

    @Published var favoriteHobbyRepository = FavoriteHobbyRespository()
    @Published var favoriteHobbyCellViewModels: [FavoriteHobbyCellViewModel] = []
    @Published var isValidate: Bool = false
    @Published var title: String = ""
    @Published var icon: String = ""

    let db = Firestore.firestore()

    private var cancellables = Set<AnyCancellable>()

    init() {

        favoriteHobbyRepository.$favoriteHobbies
            .map { favoriteHobbies in

                favoriteHobbies.map { favoriteHobby in

                    FavoriteHobbyCellViewModel(favHobby: favoriteHobby)
                }
        }
        .assign(to: \.favoriteHobbyCellViewModels, on: self)
        .store(in: &cancellables)


        Publishers.CombineLatest($title, $icon).map { (title, icon) -> Bool in

            let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)

            if !trimmedTitle.isEmpty && !icon.isEmpty {

                return true
            } else {

                return false
            }
        }
        .eraseToAnyPublisher()
        .assign(to: \.isValidate, on: self)
        .store(in: &cancellables)
    }

    func addFavoriteHobby() {

        self.favoriteHobbyRepository.addFavoriteHobby(favoriteHobby: FavoriteHobby(title: title, icon: icon))
    }

    func removeFavoriteHobby(fav: FavoriteHobby) {

        self.favoriteHobbyRepository.removeFavoriteHobby(fav: fav)
    }

    func updateFavoriteHobby(fav: FavoriteHobby, title: String, icon: String, oldTitle: String, oldIcon: String) {

        self.favoriteHobbyRepository.updateFavoriteHobby(fav: FavoriteHobby(id: fav.id, title: title, icon: icon, uesrId: fav.uesrId), oldIcon: oldIcon, oldTitle: oldTitle)
    }

}
