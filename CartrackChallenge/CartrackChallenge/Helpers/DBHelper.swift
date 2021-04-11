//
//  DBHelper.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import Foundation
import SQLite3

class DBhelper: NSObject {
    static let shared = DBhelper()
    let path = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("CarTrack.sqlite").relativePath
    var db: OpaquePointer?
    
    override init() {
        super.init()
        openDB()
    }
    
    func openDB() {
        if sqlite3_open(path, &db) != SQLITE_OK {
            print("Failed to open database")
        }
    }

    func createUserTable() -> Bool {
        let createQuery = "CREATE TABLE USER (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT, country TEXT)"
        var stmt: OpaquePointer?
        guard sqlite3_prepare(db, createQuery, -1, &stmt, nil) == SQLITE_OK else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            return false
        }
        guard sqlite3_step(stmt) == SQLITE_DONE else {
            return false
        }
        sqlite3_finalize(stmt)
        return true
    }
    
    func insertUser(username: String, password: String, country: String) -> Bool {
        let insertQuery = "INSERT INTO USER (username, password, country) VALUES (?, ?, ?)"
        var stmt: OpaquePointer?
        guard sqlite3_prepare(db, insertQuery, -1, &stmt, nil) == SQLITE_OK else {
            return false
        }
        guard sqlite3_bind_text(stmt, 1, strdup(username), -1, nil) == SQLITE_OK else {
            return false
        }
        guard sqlite3_bind_text(stmt, 2, strdup(password), -1, nil) == SQLITE_OK else {
            return false
        }
        guard sqlite3_bind_text(stmt, 3, strdup(country), -1, nil) == SQLITE_OK else {
            return false
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            sqlite3_finalize(stmt)
            return false
        }
        
        sqlite3_finalize(stmt)
        return true
    }
    
    func authenticateUser(username: String, password: String, country: String) -> Bool {
        let selectQuery = "SELECT * FROM USER WHERE username='\(username)' and password='\(password)' and country='\(country)'"
        var stmt: OpaquePointer?
        guard sqlite3_prepare(db, selectQuery, -1, &stmt, nil) == SQLITE_OK else {
            return false
        }
        if sqlite3_step(stmt) != SQLITE_ROW {
            sqlite3_finalize(stmt)
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
            return false
        }
        sqlite3_finalize(stmt)
        return true
    }
    
    func isUserExists(username: String = "") -> Bool {
        var selectQuery = "SELECT * FROM USER"
        if !username.isEmpty {
            selectQuery += " WHERE username='\(username)'"
        }
        var stmt: OpaquePointer?
        guard sqlite3_prepare(db, selectQuery, -1, &stmt, nil) == SQLITE_OK else {
            return false
        }
        if sqlite3_step(stmt) != SQLITE_ROW {
            sqlite3_finalize(stmt)
            return false
        }
        sqlite3_finalize(stmt)
        return true
    }
}
