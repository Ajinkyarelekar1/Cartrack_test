//
//  InitialisationHelper.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import Foundation
import UIKit
struct AppBuilder {
    static func initDatabase() {
        if !UserDefaults.standard.bool(forKey: UserDefaultKey.isDatabaseCreated.rawValue) {
            if DBhelper.shared.createUserTable() {
                UserDefaults.standard.set(true, forKey: UserDefaultKey.isDatabaseCreated.rawValue)
            } else {
                print("failed to create user table")
            }
        }
    }
}
