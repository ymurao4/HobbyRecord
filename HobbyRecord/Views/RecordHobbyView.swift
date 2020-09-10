//
//  RecordHobbyVIew.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct RecordHobbyView: View {

    var hobby: Hobby

    var body: some View {

        VStack {
            Text(hobby.title)
            Text(hobby.icon)
        }
    }
}

struct RecordHobbyVIew_Previews: PreviewProvider {
    static var previews: some View {
        RecordHobbyView(hobby: Hobby(date: "", title: "", details: [""], icon: ""))
    }
}
