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
    var sourceId: Int = 0
    var user: User?
    var group: Group?
    
    init(_ json: JSON) {
        
        self.authorAvatar = json.stringValue
        self.authorName = json.stringValue
        self.newsText = json["text"].stringValue
        let attachments = json["attachments"].arrayValue.first

        let sizes = attachments?["photo"]["sizes"].arrayValue


        if let zSize = sizes?.filter({$0["type"] == "z"}).first {
            self.newsImage = zSize["url"].stringValue
        } else {
            self.newsImage = sizes?.first?["url"].stringValue ?? ""
        }

        self.sourceId = json["source_id"].intValue
        
        if sourceId > 0 {
            
        }
            
        
 
        
//        self.newsImage = ""
    }

}
