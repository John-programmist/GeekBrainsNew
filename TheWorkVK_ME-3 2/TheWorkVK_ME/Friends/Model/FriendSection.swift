//
//  FriendSection.swift
//  TheWorkVK_ME
//
//  Created by Roman on 03.02.2022.
//

import Foundation
import RealmSwift


struct FriendSection: Comparable {

    var key: Character
    var data: [Friend]

    static func < (lhs: FriendSection, rhs: FriendSection) -> Bool {
        return lhs.key < rhs.key
    }

    static func == (lhs: FriendSection, rhs: FriendSection) -> Bool {
        return lhs.key == rhs.key
    }
}
