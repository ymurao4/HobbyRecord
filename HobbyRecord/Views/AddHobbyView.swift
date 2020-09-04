//
//  AddHobbyView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import QGrid

struct AddHobbyView: View {

    @Environment(\.presentationMode) var presentationMode
    @State var title: String = ""
    @State var contents: String = ""
    @State var date: Date = Date()

    private let iconNames: [String] = ["badminton", "barbell", "baseball", "basketball", "bicycle", "bike", "canvas", "football", "game", "hiking", "jogging", "karaoke", "listening", "photo", "piano", "rugbyball", "swimmer", "tramp", "volleyball", "walking", "yoga"]

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Title")) {
                        TextField("Title", text: $title)
                            .padding(5)
                        TextField("Contents", text: $contents)
                            .padding(5)
                    }
                    Section(header: Text("Date")) {
                        DatePicker(selection: $date, displayedComponents: .date) {
                            Text("Select Date")
                        }
                    }
                    Section(header: Text("Icon")) {
                        WaterfallGrid(0..<self.iconNames.count, id: \.self) { index in
                            Button(action: {

                            }) {
                                Image(self.iconNames[index])
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.primary.opacity(0.9))
                            }
                        }
                        .gridStyle(columns: 6, spacing: 15)
                        .scrollOptions(direction: .vertical, showsIndicators: false)
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "checkmark")
                        Text("Add")
                    }
                    .padding(.top, 5)
                }
            }
            .navigationBarTitle(Text("Add Hobby Record"), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
            )
        }
    }

}

struct AddHobbyView_Previews: PreviewProvider {
    static var previews: some View {
        AddHobbyView()
    }
}
