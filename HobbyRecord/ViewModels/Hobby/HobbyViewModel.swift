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

        do {

            var addedHobby = hobby
            addedHobby.uesrId = Auth.auth().currentUser?.uid
            let _ = try db.collection("hobbies").addDocument(from: addedHobby)
        } catch {

            fatalError("Unable to encode hobby: \(error.localizedDescription)")
        }
    }

    func removeRecord(hobby: Hobby) {

        if let docID = hobby.id {

            db.collection("hobbies").document(docID).delete() { err in

                if let err = err {

                    print("Error removing document: \(err.localizedDescription)")
                } else {

                    print("Document successfully removied")
                }
            }
        }
    }

}
