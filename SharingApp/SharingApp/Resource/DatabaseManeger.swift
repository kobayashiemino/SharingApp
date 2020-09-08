//
//  DatabaseManeger.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/08.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import FirebaseDatabase

class DatabaseManeger {
    static let shared = DatabaseManeger()
    private let database = Database.database().reference()
    
    // MARK: -public
    public func canCreateNewUser(email:String, username: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    public func insertNewUser(email: String, username: String, completion: @escaping (Bool) -> Void) {
        
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { (error, _) in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
}
