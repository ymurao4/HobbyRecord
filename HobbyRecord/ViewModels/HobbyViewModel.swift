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
        self.hobbyCellViewModels = testDatas.map { hobby in
            HobbyCellViewModel(hobby: hobby)
        }
    }


}
