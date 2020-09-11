//
//  DetailCellVIewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class DetailCellViewModel: ObservableObject, Identifiable {

    @Published var detail: Detail
    var id: String = ""
    private var cancellable = Set<AnyCancellable>()

    init(detail: Detail) {

        self.detail = detail

        $detail.compactMap { detail in

            detail.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellable)
    }
}

