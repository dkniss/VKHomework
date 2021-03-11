//
//  Group.swift
//  Weather
//
//  Created by Daniil Kniss on 10.12.2020.
//

import SwiftyJSON
import Foundation
import RealmSwift

class Group: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var photo: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var isMember: String = ""
    
    
    convenience required init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_50"].stringValue
        self.isMember = String(json["is_member"].intValue)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
 
}
    





    

