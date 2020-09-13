//
//  DateDetailView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/13.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct DateDetailView: View {

    @ObservedObject var dateVM: DateViewModel
    @ObservedObject var detailVM = DetailViewModel()
    var hobby: Hobby

    var body: some View {

        Form {

            Section {

                ForEach(detailVM.detailCellViewModels) { detailCell in

                    DetailCell(detailCellVM: detailCell)
                }

                Button(action: {  }) {

                    HStack {

                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Add New Detail".localized)
                    }
                    .foregroundColor(Color.orange)
                }
            }
        }
        .onAppear {

            self.addDetailCellVMToDetailVM()
        }
        .navigationBarTitle(Text(""),displayMode: .inline)
        .navigationBarItems(trailing:

            Navbar(hobby: hobby)
        )
    }

    private func addDetailCellVMToDetailVM() {

        for detail in self.hobby.details {

            self.detailVM.addDetail(detail: Detail(detail: detail))
        }
    }
}


struct Navbar: View {

    var hobby: Hobby

    var body: some View {

        ZStack(alignment: .trailing) {

            HStack {

                Image(hobby.icon)

                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.pr(9))

                Text(hobby.title)
                    .foregroundColor(Color.pr(9))
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding(.trailing, 40)

            Button(action: {

                print("udpate")
            }) {

                Text("Update")
                    .foregroundColor(Color.orange)
                    .padding(.trailing, 60)
            }
        }
    }
}
