//
//  DateCell.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/14.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct DetailCell: View {

    @ObservedObject var detailCellVM: DetailCellViewModel

    var body: some View {

        VStack {

            TextField("", text: $detailCellVM.detail.detail)
                .autocapitalization(.none)
        }
    }
}
