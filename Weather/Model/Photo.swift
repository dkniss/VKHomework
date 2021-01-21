//
//  Photo.swift
//  Weather
//
//  Created by Daniil Kniss on 21.01.2021.
//

import Foundation
import SwiftyJSON

struct Photo: Codable {
    var id: Int
    var url: String
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.url = json["sizes"][0]["url"].stringValue
    
    }
}
