//
//  DetailViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {

    @Published var detailCellViewModels: [DetailCellViewModel] = [DetailCellViewModel(detail: Detail(detail: ""))]
    @Published var details: [String] = []
    private var cancellables = Set<AnyCancellable>()

    func addDetail(detail: Detail) {

        detailCellViewModels.append(DetailCellViewModel(detail: detail))
    }

    func addAllDetailsToArray() {

        $detailCellViewModels.compactMap { detailCellVM in

            detailCellVM.compactMap { detailCell in

                detailCell.detail.detail
            }
            .filter { $0 != "" }
        }
        .assign(to: \.details, on: self)
        .store(in: &cancellables)
    }

    func removeRow(offsets: IndexSet) {

        self.detailCellViewModels.remove(atOffsets: offsets)
    }
}
