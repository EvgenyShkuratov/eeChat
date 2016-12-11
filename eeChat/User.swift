//
//  User.swift
//  eeChat
//
//  Created by Evgeny Shkuratov on 12/10/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import Foundation

struct User {
    private var _firstName: String
    private var _uid: String
    
    var uid: String {
        return _uid
    }
    
    var firstName: String {
        return _firstName
    }
    
    init(uid: String, firstName: String) {
        _uid = uid
        _firstName = firstName
    }
    
}
