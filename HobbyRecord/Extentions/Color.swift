//
//  Color.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/08/31.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

extension Color {

    static func defaultColor(colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return Color.black
        } else {
            return Color.white
        }
    }

}
