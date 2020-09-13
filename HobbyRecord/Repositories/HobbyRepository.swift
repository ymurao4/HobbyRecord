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
}
