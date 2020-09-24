//
//  SignInView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/23.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import Firebase

struct SignInView: View {

    @Environment(\.colorScheme) var colorScheem
    @Environment(\.presentationMode) var presentationMode
    @State var coordinator: SignInWithAppleCoordinator?
    @State private var isLogoutAlert: Bool = false

    let user = Auth.auth().currentUser

    var body: some View {

        VStack {

            if user?.isAnonymous ?? true {

                VStack {

                    VStack(alignment: .center, spacing: 10) {

                        Text("You are currently an anonymous user.".localized)

                        Text("If you want to link this account to other devices,".localized)

                        Text("you should sign in with apple.".localized)
                    }
                    .padding()

                    SignInWithAppleButton()
                        .frame(width: 288, height: 45)
                        .onTapGesture {

                            self.coordinator = SignInWithAppleCoordinator()

                            if let coordinator = self.coordinator {

                                coordinator.startSignInWithAppleFlow() {

                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                }
            } else {

                VStack {

                    Text("You are currently logged in with Apple.".localized)
                        .padding()

                    Button(action: { self.isLogoutAlert.toggle() }) {

                        HStack {

                            Text("Log Out".localized)
                                .foregroundColor(Color.defaultColor(colorScheme: colorScheem))
                                .padding()
                        }
                        .frame(width: 288, height: 45)
                        .background(Color.primary)
                        .cornerRadius(40)
                    }
                }
            }
        }
        .alert(isPresented: self.$isLogoutAlert) {

            logOutAlert()
        }
    }

    private func logOutAlert() -> Alert {

        Alert(
            title: Text("Log Out".localized),
            message: Text("Are you sure you want to log out?".localized),
            primaryButton: .default(Text("Log Out".localized),
                                    action: {

                                        logout()
                                    }),
            secondaryButton: .cancel(Text("Cancel".localized))
            )
    }

    private func logout() {

        let auth = Auth.auth()

        do {

            try auth.signOut()
            newUser()
            presentationMode.wrappedValue.dismiss()
            print("successfully logout")
        } catch let signOutError as NSError {

            print("Error signing out: %@", signOutError)
        }
    }

    private func newUser() {

        if Auth.auth().currentUser == nil {

            Auth.auth().signInAnonymously()
        }
    }
}
