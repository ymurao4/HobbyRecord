//
//  ContentVIew.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {

        NavigationView {
            CalendarView()
        }
    }
}

struct ContentVIew_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
