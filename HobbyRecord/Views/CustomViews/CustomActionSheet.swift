//
//  CustomActionSheet.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/09.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import StoreKit
import Firebase

struct CustomActionSheet: View {

    @State private var isSignInView: Bool = false
    @Binding var isActionSheet: Bool
//    private let buttons: [String] = ["Review This App"]
    private let buttons: [String] = ["Account", "Review This App"]
    private let version: String! = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String

    var body: some View {

        VStack(alignment: .leading, spacing: 15) {

            ForEach(buttons, id: \.self) { button in

                ChoicesButton(isActionSheet: self.$isActionSheet, isSignInView: $isSignInView, button: button)
            }

            HStack {

                Text("App Version".localized)
                Spacer()
                Text(version)
            }
            .foregroundColor(.orange)
            .padding(.vertical, 3)
            .padding(.horizontal)
        }
        .sheet(isPresented: $isSignInView) {

            SignInView()
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.top, 20)
        .padding(.horizontal)
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(25)
    }
}

struct ChoicesButton: View {

    @Binding var isActionSheet: Bool
    @Binding var isSignInView: Bool
    var button: String

    var body: some View {

        VStack {

            Button(action: {

                self.switchFunction(button: self.button)
            }) {

                HStack {

                    Text(button.localized)
                    Spacer()
                }
                .foregroundColor(.orange)
                .padding(.vertical, 3)
                .padding(.horizontal)
            }
            Divider()
        }
    }

    private func switchFunction(button: String) {

        switch button {
        case "Account":
            self.isActionSheet.toggle()
            self.isSignInView.toggle()
        case "Review This App":

            if let scene = UIApplication.shared.currentScene {

                SKStoreReviewController.requestReview(in: scene)
            }
        default:
            return
        }
    }
}

extension UIApplication {
    
    var currentScene: UIWindowScene? {
        connectedScenes
            .first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
}
