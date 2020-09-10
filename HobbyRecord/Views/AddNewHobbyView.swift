//
//  AddNewHobbyView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct AddNewHobbyView: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var hobbyVM = HobbyViewModel()
    @State var title: String = ""
    @State var icon: String = ""


    var body: some View {

        VStack {

            ZStack {

                HStack {

                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .padding()
                    }

                    Spacer()
                }

                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .cornerRadius(15)
                    .padding()
            }

            Form {

                Section(header: Text("What?")) {

                    TextField("Title", text: $title)
                        .padding(5)
                }

                Section(header: Text("Icon")) {

                    IconSetting(icon: $icon, kind: K.sports)
                    IconSetting(icon: $icon, kind: K.developments)
                    IconSetting(icon: $icon, kind: K.music)
                    IconSetting(icon: $icon, kind: K.others)
                }
            }
            .padding(.top, 20)

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
        .background(BlurView(style: .systemMaterial))
        .padding(.horizontal)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }

    private func addRecord() {

        self.presentationMode.wrappedValue.dismiss()
//        self.hobbyVM.addRecord(hobby: Hobby(date: D.formatter().string(from: self.date), title: self.title, detail: self.detail, icon: self.icon))
    }

}

struct AddHobbyView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewHobbyView()
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

