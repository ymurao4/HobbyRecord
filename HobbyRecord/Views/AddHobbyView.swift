//
//  AddHobbyView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct AddHobbyView: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var hobbyVM = HobbyViewModel()
    @State var title: String = ""
    @State var details: [String] = []
    @State var detail: String = ""
    @State var icon: String = ""
    @State var date: Date = Date()


    var body: some View {
         
        VStack {

            Form {
                Section(header: Text("What?")) {
                    TextField("Title", text: $title)
                        .padding(5)
                    TextField("Detail", text: $detail)
                        .padding(5)
                }
                Section(header: Text("When?")) {
                    // ios14のDatepickerに変更予定
                    DatePicker(selection: $date, displayedComponents: .date) {
                        Text("Select Date")
                    }
                }
                Section(header: Text("Icon")) {
                    IconSetting(icon: $icon, kind: K.sports)
                    IconSetting(icon: $icon, kind: K.developments)
                    IconSetting(icon: $icon, kind: K.music)
                    IconSetting(icon: $icon, kind: K.others)
                }
            }
            Button(action: {
                self.addRecord()
            }) {
                HStack {
                    Image(systemName: "checkmark")
                    Text("Add")
                }
                .padding(.top, 5)
            }
        }
    }

    private func addRecord() {
        self.presentationMode.wrappedValue.dismiss()
//        self.hobbyVM.addRecord(hobby: Hobby(date: D.formatter().string(from: self.date), title: self.title, detail: self.detail, icon: self.icon))
    }

}

struct AddHobbyView_Previews: PreviewProvider {
    static var previews: some View {
        AddHobbyView()
    }
}

struct IconSetting: View {

    @Binding var icon: String
    var kind: [String]

    var cellHeight: CGFloat {
        calCellHeight()
    }


    var body: some View {
        WaterfallGrid(0..<kind.count, id: \.self) { index in
            Button(action: {
                self.icon = self.kind[index]
            }) {
                Image(self.kind[index])
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.primary.opacity(0.9))
            }
        }
        .gridStyle(columns: 6, spacing: 15)
        .scrollOptions(direction: .vertical, showsIndicators: false)
        .frame(width: UIScreen.main.bounds.width, height: cellHeight)
        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
    }

    private func calCellHeight() -> CGFloat {
        let count = self.kind.count
        let row = count / 6 + 1
        return CGFloat(row * 45)
    }

}
