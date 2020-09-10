//
//  HobbyViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/01.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Combine

class HobbyViewModel :ObservableObject {
    
    @Published var hobbyCellViewModels = [HobbyCellViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {

        self.hobbyCellViewModels = testDataHobbies.map { hobby in
            HobbyCellViewModel(hobby: hobby)
        }
    }

    func addRecord(hobby: Hobby) {

        let hobbyCellVM = HobbyCellViewModel(hobby: hobby)
        self.hobbyCellViewModels.append(hobbyCellVM)
    }

}
