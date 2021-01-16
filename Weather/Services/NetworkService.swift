//
//  NetworkService.swift
//  Weather
//
//  Created by Daniil Kniss on 16.01.2021.
//

import Foundation
import Alamofire


class NetworkService {
    
    static func loadGroups(token: String) {
        let host = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.126"
        ]
        
        AF.request(host + path, method: .get, parameters: params).responseJSON { json in
            print(json)
        }
    }
    
    static func loadFriends(token: String) {
        let host = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
            "v": "5.126"
        ]
        
        AF.request(host + path, method: .get, parameters: params).responseJSON { json in
            print(json)
        }
    }
    
    static func loadPhotos(token: String) {
        let host = "https://api.vk.com"
        let path = "/method/photos.get"
        
        let params: Parameters = [
            "access_token": token,
            "album_id": "profile",
            "v": "5.126"
        ]
        
        AF.request(host + path, method: .get, parameters: params).responseJSON { json in
            print(json)
        }
    }
    
    static func loadSearchedGroups(token: String) {
        let host = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": token,
            "q": "Music",
            "v": "5.126"
        ]
        
        AF.request(host + path, method: .get, parameters: params).responseJSON { json in
            print(json)
        }
    }
    
}
