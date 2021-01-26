//
//  User.swift
//  Weather
//
//  Created by Daniil Kniss on 10.12.2020.
//

import Foundation
import SwiftyJSON
import RealmSwift

class User: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var photo: String = ""
    
    convenience required init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo = json["photo_50"].stringValue
    }
}


