//
//  HistoryRepository.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/10/05.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class HistoryHobbyRepository: ObservableObject {

    @Published var hobbies: [Hobby] = []
    let db = Firestore.firestore()

    func loadDate(sortName: String) {

        let userId = Auth.auth().currentUser?.uid

        db.collection("hobbies")
            .whereField("uesrId", isEqualTo: userId as Any)
            .whereField("title", isEqualTo: sortName)
            .order(by: "date", descending: false)
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

}
