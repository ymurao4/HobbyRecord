//
//  BlurView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/29.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct BlurView: UIViewRepresentable {

    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {

        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

