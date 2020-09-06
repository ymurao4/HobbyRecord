//
//  DetailViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/06.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

class DetailViewModel: ObservableObject {

    @Published var date: Date = Date()
    var hobbyVM: HobbyViewModel
    var imageName: String {
        getImageName()
    }

    init(date: Date, hobbyVM: HobbyViewModel) {
        self.date = date
        self.hobbyVM = hobbyVM
    }

    private func getImageName() -> String {
        var iconName: String = ""
        for hobbyCellVM in self.hobbyVM.hobbyCellViewModels {
            let stringDate = hobbyCellVM.hobby.date
            if  stringDate == D.formatter.string(from: date) {
                if let imageName = hobbyCellVM.hobby.icon {
                    iconName = imageName
                }
            }
        }
        return iconName
    }

}
