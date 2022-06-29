//
//  SessionSinglton.swift
//  TheWorkVK_ME
//
//  Created by Roman on 03.01.2022.
//

import Foundation

struct Session{
    
    static var instance = Session()
    
    private init() {}
    
    var token: String = ""
    var useID: Int = 0
}
