//
//  AddHobbyView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct AddHobbyView: View {

    @Environment(\.presentationMode) var presentationMode
    @State var title: String = ""
    @State var contents: String = ""

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
                    Section(header: Text("Icon")) {
                        Button(action: {

                        }) {
                            Image("swimmer")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.primary.opacity(0.9))
                        }
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
        }
    }

}

struct AddHobbyView_Previews: PreviewProvider {
    static var previews: some View {
        AddHobbyView()
    }
}
