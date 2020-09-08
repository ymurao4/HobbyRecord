//
//  ContentVIew.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentVIew: View {

    @State var width = UIScreen.main.bounds.width - 90
    // to hide view...
    @State var x = -UIScreen.main.bounds.width + 90

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {

            CalendarView(x: $x)

            SlideMenu()
                .shadow(color: Color.black.opacity(self.x != 0 ? 0.5 : 0), radius: 5, x: 5, y: 0)
                .offset(x: x)
                .background(Color.black.opacity(x == 0 ? 0.5 : 0).edgesIgnoringSafeArea(.all))
                .onTapGesture {

                    // 戻る
                    withAnimation {

                        self.x = -self.width
                    }
            }
        }
    }
}

struct ContentVIew_Previews: PreviewProvider {
    static var previews: some View {
        ContentVIew()
    }
}
