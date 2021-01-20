//
//  NetworkService.swift
//  Weather
//
//  Created by Daniil Kniss on 16.01.2021.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkService {
    
    static func loadUserGroups(token: String, userId: Int,  completion: @escaping ([Group]) -> Void) {
        let host = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.126",
            "user_id": userId
        ]
        
        AF.request(host+path, method: .get, parameters: params).responseData { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                let groupsJSON = json["response"]["items"].arrayValue
                let groups = groupsJSON.compactMap { Group($0) }
                groups.forEach { print($0.name) }
                completion(groups)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func loadAllGroups(token: String, completion: @escaping ([Group]) -> Void) {
        let host = "https://api.vk.com"
        let path = "/method/groups.getCatalog"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.126",
        ]
        
        AF.request(host+path, method: .get, parameters: params).responseData { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                let groupsJSON = json["response"]["items"].arrayValue
                let groups = groupsJSON.compactMap { Group($0) }
                groups.forEach { print($0.name) }
                completion(groups)
            case .failure(let error):
                print(error)
            }
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
            "v": "5.126",
            
        ]
        
        AF.request(host + path, method: .get, parameters: params).responseJSON { json in
            print("Load Searched Groups")
        }
    }
    
}
