//
//  DetailView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/04.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct DetailView: View {

    
    var date: Date

    var body: some View {
        Text("Hello world!")
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height - 150)
            .background(Color.orange.opacity(0.5))
    }

}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(date: Date())
    }
}
