//
//  CLDateViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/13.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class CLDateHobbyViewModel: ObservableObject {

    @Published var hobbyVM: HobbyViewModel

    private var cancellables = Set<AnyCancellable>()

    init(hobbyVM: HobbyViewModel) {

        self.hobbyVM = hobbyVM
    }
}
