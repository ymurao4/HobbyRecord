//
//  ContentVIew.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State var isActionSheet: Bool = false

    var body: some View {

        NavigationView {

            ZStack {
                
                CalendarView(isActionSheet: $isActionSheet)

                GeometryReader{ reader in

                    ReaderView(reader: reader)
                        .edgesIgnoringSafeArea(.all)
                }

                VStack {

                    Spacer()

                    CustomActionSheet()
                        .offset(y: self.isActionSheet ? 0 : UIScreen.main.bounds.height)
                }
                .background((self.isActionSheet ? Color.black.opacity(0.3) : Color.clear)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {

                        self.isActionSheet.toggle()
                    }
                )
                .edgesIgnoringSafeArea(.bottom)
            }
            .animation(.default)
        }
    }
}

struct ContentVIew_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



