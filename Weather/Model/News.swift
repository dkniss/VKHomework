//
//  News.swift
//  Weather
//
//  Created by Daniil Kniss on 19.12.2020.
//

import Foundation
import SwiftyJSON

class News {
    var authorAvatar: String = ""
    var authorName: String = ""
    var newsText: String = ""
    var newsImage: String = ""
    var user: User?
    var group: Group?
    
    init(_ json: JSON) {
        self.authorAvatar = json.stringValue
        self.authorName = json.stringValue
        self.newsText = json["text"].stringValue
        self.newsImage = ""
    }

}
