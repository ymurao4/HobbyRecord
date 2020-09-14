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

    func addFavoriteHobby(favoriteHobby: FavoriteHobby) {

        do {

            var addedFavoriteHobby = favoriteHobby
            addedFavoriteHobby.uesrId = Auth.auth().currentUser?.uid
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

    func updateFavoriteHobby(fav: FavoriteHobby) {

        if let favId = fav.id {

            do {
                try db.collection("favorites").document(favId).setData(from: fav)
            } catch {

                fatalError("Unable to encode hobby: \(error.localizedDescription)")
            }
        }
    }

}
