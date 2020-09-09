//
//  ReaderView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ReaderView: View {

    @State var offset: CGFloat = 0
    var reader: GeometryProxy

    var body: some View {

        VStack {

            BottomSheet()
                .offset(y: reader.frame(in: .global).height + 10)
                .offset(y: self.offset)
                .gesture(DragGesture()
                    .onChanged({ (value) in

                        withAnimation {

                            // checking the direction of scroll
                            if value.startLocation.y > self.reader.frame(in: .global).midX {

                                if value.translation.height < 0 && self.offset > (-self.reader.frame(in: .global).height + 100) {

                                    self.offset = value.translation.height
                                }
                            }

                            if value.startLocation.y < self.reader.frame(in: .global).midX {

                                if value.startLocation.y < self.reader.frame(in: .global).midX {

                                    if value.translation.height > 0 && self.offset < 0 {

                                        self.offset = (-self.reader.frame(in: .global).height + 100) + value.translation.height
                                    }
                                }
                            }
                        }
                    })
                    .onEnded({ (value) in

                        withAnimation {

                            if value.startLocation.y > self.reader.frame(in: .global).midX {

                                if -value.translation.height > self.reader.frame(in: .global).midX {

                                    self.offset = (-self.reader.frame(in: .global).height + 100)
                                    return
                                }

                                self.offset = 0
                            }

                            if value.startLocation.y < self.reader.frame(in: .global).midX {

                                if value.translation.height < self.reader.frame(in: .global).midX {

                                    self.offset = (-self.reader.frame(in: .global).height + 100)
                                    return
                                }

                                self.offset = 0
                            }
                        }
                    }))

        }
    }
}
