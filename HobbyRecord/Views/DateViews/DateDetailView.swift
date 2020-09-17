//
//  DateDetailView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/13.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct DateDetailView: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var dateVM: DateViewModel
    @ObservedObject var detailVM = DetailViewModel()
    @ObservedObject var hobbyVM: HobbyViewModel
    var hobby: Hobby

    init(dateVM: DateViewModel, hobby: Hobby, hobbyVM: HobbyViewModel) {

        self.dateVM = dateVM
        self.hobby = hobby
        self.hobbyVM = hobbyVM

        self.addDetailCellVMToDetailVM()
    }

    var body: some View {

        Form {

            Section {

                ForEach(detailVM.detailCellViewModels) { detailCell in

                    DetailCell(detailCellVM: detailCell)
                }
                .onDelete(perform: rowRemove)

                Button(action: {

                    self.detailVM.addDetail(detail: Detail(detail: ""))
                }) {

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

            navbar
        )
    }

    private func addDetailCellVMToDetailVM() {

        self.detailVM.detailCellViewModels.removeAll()

        for detail in self.hobby.details {

            self.detailVM.addDetail(detail: Detail(detail: detail))
        }
    }

    private func rowRemove(offsets: IndexSet) {

        self.detailVM.removeRow(offsets: offsets)
    }

    private var navbar: some View {

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

                self.updateRecord()
            }) {

                Text("Update".localized)
                    .foregroundColor(Color.orange)
                    .padding(.trailing, 60)
            }
        }
    }

    private func updateRecord() {

        let newHobby = self.detailVM.updateRecord(hobby: self.hobby)
        self.hobbyVM.updateRecord(hobby: newHobby)
        self.presentationMode.wrappedValue.dismiss()
    }
}

