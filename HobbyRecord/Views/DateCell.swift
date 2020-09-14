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

        // SwiftUIのTextFieldは日本語入力に不具合があるので、UIViewRepresentableから利用
         TextField("", text: $detailCellVM.detail.detail)
//        _TextField(title: detailCellVM.detail.detail, text: $detailCellVM.detail.detail)
    }
}
