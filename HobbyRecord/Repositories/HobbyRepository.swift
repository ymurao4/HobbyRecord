//
//  HobbyRepository.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/13.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class HobbyRepository: ObservableObject {

    @Published var hobbies: [Hobby] = []
    let db = Firestore.firestore()

    init() {

        loadData()
    }

    func loadData() {

        let userId = Auth.auth().currentUser?.uid

        db.collection("hobbies")
            .whereField("uesrId", isEqualTo: userId as Any)
            .addSnapshotListener { (querySnapshot, error) in

                if let querySnapshot = querySnapshot {

                    self.hobbies = querySnapshot.documents.compactMap { document in

                        do {

                            let x = try document.data(as: Hobby.self)
                            return x
                        } catch {

                            print(error.localizedDescription)
                        }
                        return nil
                    }
                }
        }
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

    func updateRecord(hobby: Hobby) {

        if let hobbyId = hobby.id {

            do {

                try db.collection("hobbies").document(hobbyId).setData(from: hobby)
            } catch {

                fatalError("Unable to encode hobby: \(error.localizedDescription)")
            }
        }
    }
}
