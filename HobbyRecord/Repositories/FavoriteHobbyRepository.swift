//
//  FavoriteHobbyRepository.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/13.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FavoriteHobbyRespository: ObservableObject {

    @Published var favoriteHobbies: [FavoriteHobby] = []
    let db = Firestore.firestore()

    init() {
        loadDate()
    }

    func loadDate() {

        let userId = Auth.auth().currentUser?.uid

        db.collection("favorites")
            .whereField("uesrId", isEqualTo: userId as Any)
            .addSnapshotListener { (querySnapshot, error) in

                if let querySnapshot = querySnapshot {

                    self.favoriteHobbies = querySnapshot.documents.compactMap { document in

                        do {

                            let x = try document.data(as: FavoriteHobby.self)
                            return x
                        } catch {

                            print(error.localizedDescription)
                        }
                        return nil
                    }
                }
        }
    }

}
