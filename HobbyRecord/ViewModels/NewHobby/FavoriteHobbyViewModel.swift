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
    @Published var favoriteHobby: FavoriteHobby?

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

        if favoriteHobby == nil {

            self.favoriteHobbyRepository.addFavoriteHobby(favoriteHobby: FavoriteHobby(title: title, icon: icon))
        } else {

            updateFavoriteHobby(fav: favoriteHobby!)
        }
    }

    func removeFavoriteHobby(fav: FavoriteHobby) {

        self.favoriteHobbyRepository.removeFavoriteHobby(fav: fav)
    }

    func updateFavoriteHobby(fav: FavoriteHobby) {

        self.favoriteHobbyRepository.updateFavoriteHobby(fav: FavoriteHobby(id: fav.id, title: title, icon: icon, uesrId: fav.uesrId))
    }

}
