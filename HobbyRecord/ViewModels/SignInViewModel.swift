//
//  SignInViewModel.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/27.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

class SignInViewModel: ObservableObject {

    @Published var hobbyRepository = HobbyRepository()
    @Published var favoriteRepository = FavoriteHobbyRespository()

    func reLoadRecord() {

        hobbyRepository.loadData()
        favoriteRepository.loadDate()
    }
}
