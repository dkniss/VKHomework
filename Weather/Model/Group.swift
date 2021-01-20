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
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_50"
        case name
        
    }
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.photo = json["photo_50"].stringValue
    }
    
 
    }
    
    




    

