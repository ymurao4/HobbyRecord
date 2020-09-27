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

    @Published var hobbyRepository = HobbyRepository()
    @Published var favoriteHobbies: [FavoriteHobby] = []
    let db = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid

    init() {
        
        loadDate()
    }

    func loadDate() {


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

                    self.removeAllHobbyRecord(fav: fav)
                }
            }
        }
    }

    private func removeAllHobbyRecord(fav: FavoriteHobby) {

        db.collection("hobbies")
            .whereField("uesrId", isEqualTo: userId as Any)
            .whereField("title", isEqualTo: fav.title)
            .whereField("icon", isEqualTo: fav.icon)
            .getDocuments() { (querySnapshot, error) in

                if let error = error {

                    print("Error getting documents: \(error)")
                } else {

                    for document in querySnapshot!.documents {

                        self.db.collection("hobbies").document(document.documentID).delete() { err in

                            if let err = err {

                                print("Error removing document: \(err.localizedDescription)")
                            } else {

                                print("Record susccessfully deleted")
                            }
                        }
                    }
                }
        }
    }

    func updateFavoriteHobby(fav: FavoriteHobby, oldIcon: String, oldTitle: String) {

        if let favId = fav.id {

            do {

                try db.collection("favorites").document(favId).setData(from: fav)

                updateAllHobbyRecord(fav: fav, oldIcon: oldIcon, oldTitle: oldTitle)
            } catch {

                fatalError("Unable to encode hobby: \(error.localizedDescription)")
            }
        }

    }

    private func updateAllHobbyRecord(fav: FavoriteHobby, oldIcon: String, oldTitle: String) {

        db.collection("hobbies")
            .whereField("uesrId", isEqualTo: userId as Any)
            .whereField("title", isEqualTo: oldTitle)
            .whereField("icon", isEqualTo: oldIcon)
            .getDocuments() { (querySnapshot, error) in

                if let error = error {

                    print("Error getting documents: \(error)")
                } else {

                    for document in querySnapshot!.documents {

                        do {

                            var hobby = try document.data(as: Hobby.self)
                            hobby!.title = fav.title
                            hobby!.icon = fav.icon
                            try self.db.collection("hobbies").document(document.documentID).setData(from: hobby)
                        } catch {

                            fatalError("Unable to encode hobby: \(error.localizedDescription)")
                        }
                    }
                }
        }
    }

}
