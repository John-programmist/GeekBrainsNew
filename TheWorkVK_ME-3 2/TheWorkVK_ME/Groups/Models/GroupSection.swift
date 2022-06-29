//
//  GroupSection.swift
//  TheWorkVK_ME
//
//  Created by Roman on 05.02.2022.
//

import Foundation


struct GroupSection: Comparable {

    var key: Character
    var data: [Groups]

    static func < (lhs: GroupSection, rhs: GroupSection) -> Bool {
        return lhs.key < rhs.key
    }

    static func == (lhs: GroupSection, rhs: GroupSection) -> Bool {
        return lhs.key == rhs.key
    }
}

