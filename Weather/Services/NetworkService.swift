//
//  NetworkService.swift
//  Weather
//
//  Created by Daniil Kniss on 16.01.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class NetworkService {
    
    static func loadUserGroups(token: String, userId: Int, completion: @escaping ([Group]) -> Void) {
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
                print("GROUPSJSONS: \(groupsJSON)")
                let groups = groupsJSON.compactMap { Group($0) }
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
    
    
    static func loadFriends(token: String, completion: @escaping ([User]) -> Void ) {
        let host = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
            "v": "5.126",
            "fields": "photo_50"
        ]
        
        AF.request(host + path, method: .get, parameters: params).responseData { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                let friendsJSONs = json["response"]["items"].arrayValue
                let friends = friendsJSONs.compactMap { User($0) }
                friends.forEach { print($0.firstName) }
                completion(friends)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func loadPhotos(token: String, ownerId: Int, completion: @escaping ([Photo]) -> Void ) {
        let host = "https://api.vk.com"
        let path = "/method/photos.get"
        
        let params: Parameters = [
            "access_token": token,
            "owner_id": ownerId,
            "album_id": "profile",
            "photo_sizes": 1,
            "v": "5.126"
        ]
        
        AF.request(host + path, method: .get, parameters: params).responseData { response in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
                let photosJSONs = json["response"]["items"].arrayValue
                print("PHOTOSJSONS: \(photosJSONs)")
                let photos = photosJSONs.compactMap { Photo($0) }
                completion(photos)
                print(photos)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func saveFriendsData(_ friends: [User]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(friends)
            try realm.commitWrite()
            print(realm.configuration.fileURL!)
        } catch {
            print(error)
        }
    }
    
    static func saveGroupsData(_ groups: [Group]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(groups)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    static func savePhotosData(_ photos: [Photo]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photos)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    static func joinGroup(token: String, groupId: Int) {
        let host = "https://api.vk.com"
        let path = "/method/groups.join"
        
        let params: Parameters = [
            "access_token": token,
            "group_id": groupId,
            "v": "5.126"
        ]
        
        AF.request(host + path, method: .post, parameters: params).responseData { response in
            print(response)
        }
    }
    
    static func leaveGroup(token: String, groupId: Int) {
        let host = "https://api.vk.com"
        let path = "/method/groups.leave"
        
        let params: Parameters = [
            "access_token": token,
            "group_id": groupId,
            "v": "5.126"
        ]
        
        AF.request(host + path, method: .post, parameters: params).responseJSON { response in
            print(response)
        }
    }
    
}
