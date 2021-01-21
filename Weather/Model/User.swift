//
//  User.swift
//  Weather
//
//  Created by Daniil Kniss on 10.12.2020.
//

import Foundation
import SwiftyJSON

struct User: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var photo: String
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photo = json["photo_50"].stringValue
    }
}


