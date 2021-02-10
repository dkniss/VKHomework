//
//  FirebaseUser.swift
//  Weather
//
//  Created by Daniil Kniss on 10.02.2021.
//

import Foundation
import Firebase

class FirebaseUser {
    let userId: Int
    let ref: DatabaseReference?
    
    init(userId: Int) {
        self.userId = userId
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let userId = value["userId"] as? Int
            
        else { return nil }
        
        self.ref = snapshot.ref
        self.userId = userId
            
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "userId": userId
        ]
    }
}
