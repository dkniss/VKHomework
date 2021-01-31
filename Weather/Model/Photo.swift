//
//  Photo.swift
//  Weather
//
//  Created by Daniil Kniss on 21.01.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Photo: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var ownerId: String = ""
   
    
    convenience required init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.url = json["sizes"][4]["url"].stringValue
        self.ownerId = String(json["owner_id"].intValue)
    
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
