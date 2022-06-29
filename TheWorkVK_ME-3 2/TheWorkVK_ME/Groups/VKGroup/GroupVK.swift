//
//  GroupVK.swift
//  TheWorkVK_ME
//
//  Created by Roman on 24.01.2022.
//

import Foundation
import RealmSwift


struct GroupVK: Decodable {
    let response: ResponseGroup
}

struct ResponseGroup: Decodable {
    let count: Int
    let items: [Groups]
}


class Groups: Object, Decodable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var type: String
    @Persisted var photo50: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "name"
        case type = "type"
        case photo50 = "photo_50"
    }

}
