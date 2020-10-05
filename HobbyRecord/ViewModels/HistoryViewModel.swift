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

//    @Published var hobbyVM = HobbyViewModel()
    @Published var historyRepository = HistoryHobbyRepository()
    @Published var hobbies: [Hobby] = []

    private var cancellables = Set<AnyCancellable>()

    func filterRecord(title: String) {

        historyRepository.loadDate(sortName: title)

        historyRepository.$hobbies
            .assign(to: \.hobbies, on: self)
            .store(in: &cancellables)
    }
}
