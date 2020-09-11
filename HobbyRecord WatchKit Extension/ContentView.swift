//
//  ContentView.swift
//  HobbyRecord WatchKit Extension
//
//  Created by 村尾慶伸 on 2020/08/28.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {

        List {

            ForEach(0..<5, id: \.self) { i in

                Text("\(i + 1)番目だお")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
