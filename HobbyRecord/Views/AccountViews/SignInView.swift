//
//  SignInView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/23.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import Firebase

enum ActiveAlert {
    case first, second
}

struct SignInView: View {

    @Environment(\.colorScheme) var colorScheem
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var signInVM = SignInViewModel()
    @State var coordinator: SignInWithAppleCoordinator?
    @State private var isLogoutAlert: Bool = false
    @State private var isAlert: Bool = false
    @State private var activeAlert: ActiveAlert = .first

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

                                    activeAlert = .second
                                    isAlert.toggle()
                                }
                            }
                        }
                }
            } else {

                VStack {

                    Text("You are currently logged in with Apple.".localized)
                        .padding()

                    Button(action: {

                        self.activeAlert = .first
                        self.isAlert = true
                    }) {

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
        .alert(isPresented: self.$isAlert) {

            switch activeAlert {
            case .first:

                return logOutAlert()
            case .second:

                return restartAlert()
            }
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

    private func restartAlert() -> Alert {

        Alert(
            title: Text("Please restart this app.".localized),
            message: Text(""),
            dismissButton: .default(Text("OK".localized), action: {

                presentationMode.wrappedValue.dismiss()
            }))
    }

    private func logout() {

        let auth = Auth.auth()

        do {

            try auth.signOut()
            newUser()
            print("successfully logout")
        } catch let signOutError as NSError {

            print("Error signing out: %@", signOutError)
        }

        self.activeAlert = .second
        self.isAlert = true
    }

    private func newUser() {

        if Auth.auth().currentUser == nil {

            Auth.auth().signInAnonymously()
        }
    }
}
