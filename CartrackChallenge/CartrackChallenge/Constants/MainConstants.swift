//
//  MainConstants.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import Foundation
struct MainConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com/"
}

enum StoryBoards: String {
    case main = "Main"
}

enum APIServices: String {
    case users = "users"
    
    var endpoint: String {
        switch self {
        case .users:
            return MainConstants.baseURL + self.rawValue
        }
    }
}
