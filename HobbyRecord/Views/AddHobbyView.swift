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
                        Image("swimmer")
                    }
                }
            }
            .navigationBarTitle(Text("Add Hobby Record"), displayMode: .inline)
            .navigationBarItems(
                leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                },
                trailing:
                Button(action: {
                    print("done")
                }) {
                    Text("Done")
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
