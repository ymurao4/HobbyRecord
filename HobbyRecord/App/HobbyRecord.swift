//
//  HobbyRecord.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/10/02.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import Firebase
import IQKeyboardManagerSwift

@main
struct HobbyRecord: App {

    @UIApplicationDelegateAdaptor(Delegate.self) var delegate

    var body: some Scene {

        WindowGroup {

            ContentView()
        }
    }
}


class Delegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //MARK: - FIREBASE
        FirebaseApp.configure()

        if Auth.auth().currentUser == nil {

            Auth.auth().signInAnonymously()
        }

        //MARK: - IQKEYBOARDMANAGER
        IQKeyboardManager.shared.enable = true

        //MARK: - TABLEVIEWCELL
        // cellの色
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear

        return true
    }
}
