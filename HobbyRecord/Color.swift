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

    static var bl: Color = Color.black.opacity(0.9)
    static var wh: Color = Color.white.opacity(0.9)
    static var pr: Color = Color.primary.opacity(0.9)

}
