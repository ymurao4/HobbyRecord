//
//  DetailViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Combine

class DetailViewModel: ObservableObject {

    @Published var detailCellViewModels = [DetailCellViewModel]()
    private var cancellables = Set<AnyCancellable>()

    init() {
        
    }
}
