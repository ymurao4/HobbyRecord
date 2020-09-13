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

        do {

            let userId = Auth.auth().currentUser?.uid

            let addedFavoriteHobby = FavoriteHobby(title: title, icon: icon, uesrId: userId)
            let _ = try db.collection("favorites").addDocument(from: addedFavoriteHobby)
        } catch {

            fatalError("Unable to enchode favoriteHobby: \(error.localizedDescription)")
        }
    }

    func removeFavoriteHobby(fav: FavoriteHobby) {

        if let docID = fav.id {

            db.collection("favorites").document(docID).delete() { err in

                if let err = err {

                    print("Error removing document: \(err.localizedDescription)")
                } else {

                    print("Document successfully removied")
                }
            }
        }
    }
}
