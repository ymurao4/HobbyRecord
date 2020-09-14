//
//  HobbyViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/01.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class HobbyViewModel: ObservableObject {
    
    @Published var hobbyCellViewModels: [HobbyCellViewModel] = []
    @Published var hobbyRepository = HobbyRepository()

    let db = Firestore.firestore()

    private var cancellables = Set<AnyCancellable>()

    init() {

        hobbyRepository.$hobbies
            .map { hobbies in

                hobbies.map { hobby in
                    HobbyCellViewModel(hobby: hobby)
                }
        }
        .assign(to: \.hobbyCellViewModels, on: self)
        .store(in: &cancellables)
    }

    func addRecord(hobby: Hobby) {

        self.hobbyRepository.addRecord(hobby: hobby)
    }

    func removeRecord(hobby: Hobby) {

        self.hobbyRepository.removeRecord(hobby: hobby)
    }

    func updateRecord(hobby: Hobby) {

        self.hobbyRepository.updateRecord(hobby: hobby)
    }

}
