//
//  DetailViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/06.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class DateViewModel: ObservableObject {

    @Published var hobbies: [Hobby] = []
    var date: Date
    var hobbyVM: HobbyViewModel

    private var cancellable = Set<AnyCancellable>()

    init(date: Date, hobbyVM: HobbyViewModel) {

        self.date = date
        self.hobbyVM = hobbyVM
        self.filterHobby()
    }

    func filterHobby() {

        hobbies.removeAll()
        self.hobbyVM.$hobbyCellViewModels.sink { hobbyCellViewModel in

            let _ = hobbyCellViewModel.filter { (hobbyCell) -> Bool in

                if hobbyCell.hobby.date == D.formatter.string(from: self.date) {

                    self.hobbies.append(hobbyCell.hobby)
                    return true
                } else {

                    return false
                }
            }
        }
        .store(in: &cancellable)
    }
}
