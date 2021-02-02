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
        self.ownerId = json["owner_id"].stringValue
        let sizes = json["sizes"].arrayValue
        if let zSize = sizes.filter({$0["type"] == "z"}).first {
            self.url = zSize["url"].stringValue
        } else {
            self.url = sizes[0]["url"].stringValue
        }
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
