//
//  HistoryViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/10/05.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class HistoryViewModel: ObservableObject {

    @Published var hobbyVM = HobbyViewModel()
    @Published var hobbies: [Hobby] = []

    private var cancellables = Set<AnyCancellable>()

    func filterRecord(title: String) {

        hobbyVM.$hobbyCellViewModels.sink { hobbyCellVMs in

            let _ = hobbyCellVMs.filter { hobbyCellVM in

                if hobbyCellVM.hobby.title == title {

                    self.hobbies.append(hobbyCellVM.hobby)
                    return true
                } else {

                    return false
                }
            }
        }
        .store(in: &cancellables)
    }
}
