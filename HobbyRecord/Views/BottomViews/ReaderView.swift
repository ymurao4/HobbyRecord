//
//  ReaderView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI


struct ReaderView: View {

    @ObservedObject var favoriteHobbyVM: FavoriteHobbyViewModel
    @State var offset: CGFloat = 0
    var reader: GeometryProxy

    var height: CGFloat = { () -> CGFloat in

        var height: CGFloat = 0

        if UIDevice().userInterfaceIdiom == .phone {
            // Simulator iPhone 8
            switch UIScreen.main.nativeBounds.height {
            case 1334, 1920, 2208, 1024, 2048, 2224, 2160, 2388, 2732:

                height = 60
            case 2436, 1792, 2688:

                height = 0
            default:
                height = 0
            }
        }
        return height
    }()

    var body: some View {

        VStack {

            BottomSheet(favoriteHobbyVM: favoriteHobbyVM, offset: $offset)
                .offset(y: reader.frame(in: .global).height - height)
                .offset(y: self.offset)
                .gesture(DragGesture()
                    .onChanged({ (value) in

                        withAnimation {

                            // checking the direction of scroll
                            if value.startLocation.y > self.reader.frame(in: .global).midX {

                                if value.translation.height < 0 && self.offset > (-self.reader.frame(in: .global).height + 100 + height) {

                                    self.offset = value.translation.height
                                }
                            }

                            if value.startLocation.y < self.reader.frame(in: .global).midX {

                                if value.startLocation.y < self.reader.frame(in: .global).midX {

                                    if value.translation.height > 0 && self.offset < 0 {

                                        self.offset = (-self.reader.frame(in: .global).height + 100 + height) + value.translation.height
                                    }
                                }
                            }
                        }
                    })
                    .onEnded({ (value) in

                        withAnimation {

                            if value.startLocation.y > self.reader.frame(in: .global).midX {

                                if -value.translation.height > self.reader.frame(in: .global).midX {

                                    self.offset = (-self.reader.frame(in: .global).height + 100 + height)
                                    return
                                }

                                self.offset = 0
                            }

                            if value.startLocation.y < self.reader.frame(in: .global).midX {

                                if value.translation.height < self.reader.frame(in: .global).midX {

                                    self.offset = (-self.reader.frame(in: .global).height + 100 + height)
                                    return
                                }

                                self.offset = 0
                            }
                        }
                    }))

        }
    }
}
