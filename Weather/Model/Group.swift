//
//  Group.swift
//  Weather
//
//  Created by Daniil Kniss on 10.12.2020.
//

import SwiftyJSON
import Foundation

struct Group: Codable {
    var id: Int
    var photo: String
    var name: String 
    
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_50"].stringValue
    }
    
 
}
    

extension Group: Equatable {
    static func ==(lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
}



    

