//
//  DetailViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Combine

class DetailViewModel: ObservableObject {

    @Published var detailCellViewModels: [DetailCellViewModel] = []
    @Published var details: [String] = []
    private var cancellables = Set<AnyCancellable>()

    func addDetail(detail: Detail) {

        detailCellViewModels.append(DetailCellViewModel(detail: detail))
    }

    func addAllDetailsToArray() {

        $detailCellViewModels.map { detailCellVM in

            detailCellVM.map { detailCell in

                detailCell.detail.detail
            }
        }
        .assign(to: \.details, on: self)
        .store(in: &cancellables)
    }
}
