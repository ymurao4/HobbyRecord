//
//  HobbyCellViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/01.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Combine

class HobbyCellViewModel: ObservableObject, Identifiable {

    @Published var hobby: Hobby
    var id: String = ""
    private var cancellable = Set<AnyCancellable>()

    init(hobby: Hobby) {
        self.hobby = hobby

        $hobby.map { hobby in
            hobby.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellable)
    }

}
