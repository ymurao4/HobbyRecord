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

    @Published var hobbyRepository = HobbyRepository()
    @Published var hobbies: [Hobby] = []

    private var cancellables = Set<AnyCancellable>()

    init() {

        hobbyRepository.$hobbies.sink { records in

            print(records)
        }
        .store(in: &cancellables)
    }

}
