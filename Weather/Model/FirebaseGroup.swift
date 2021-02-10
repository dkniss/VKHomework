//
//  FirebaseGroup.swift
//  Weather
//
//  Created by Daniil Kniss on 09.02.2021.
//

import Foundation
import Firebase

class FirebaseGroup {
    let groupName: String
    let groupId: Int
    let ref: DatabaseReference?
    
    init(groupName: String, groupId: Int) {
        self.groupName = groupName
        self.groupId = groupId
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let groupName = value["groupName"] as? String,
            let groupId = value["groupId"] as? Int
        else { return nil }
        
        self.ref = snapshot.ref
        self.groupName = groupName
        self.groupId = groupId
            
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "groupName" : groupName,
            "groupId" : groupId
        ]
    }
}
