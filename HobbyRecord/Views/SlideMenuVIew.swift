//
//  SlideMenuVIew.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import SwiftUI

struct SlideMenu : View {

    @Environment(\.colorScheme) var colorScheme
    var edges = UIApplication.shared.windows.first?.safeAreaInsets

    var body: some View{

        HStack(spacing: 0) {

            VStack(alignment: .leading) {

                AddHobbyView()
            }
            .padding(.horizontal,20)
            .padding(.top,edges!.top == 0 ? 15 : edges?.top)
            .padding(.bottom,edges!.bottom == 0 ? 15 : edges?.bottom)
            .frame(width: UIScreen.main.bounds.width - 90, height: UIScreen.main.bounds.height)
            .background(Color.defaultColor(colorScheme: colorScheme))

            Spacer(minLength: 0)
        }
    }
}
