//
//  FriendsVK.swift
//  TheWorkVK_ME
//
//  Created by Roman on 17.01.2022.
//

import RealmSwift
import Foundation

struct FriendsVK: Decodable {
    let response: ResponseFriends
}

struct ResponseFriends: Decodable {
    let count: Int
    let items: [Friend]
}


class Friend: Object, Decodable{
    

    @Persisted(primaryKey: true) var id: Int

    @Persisted
    var firstName: String

    @Persisted
    var lastName: String

    @Persisted
    var photo50: String
    
    @Persisted
    var photo100: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
    }
}



