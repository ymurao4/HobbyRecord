//
//  Color.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/29.
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

    static func bl(_ n: Double) -> Color {

        return Color.black.opacity(n / 10)
    }

    static func wh(_ n: Double) -> Color {

        return Color.white.opacity(n / 10)
    }

    static func pr(_ n: Double) -> Color {

        return Color.primary.opacity(n / 10)
    }

}
