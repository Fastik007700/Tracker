//
//  User.swift
//  Tracker
//
//  Created by Mikhail on 01/10/2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import Foundation
import RealmSwift


class User: Object {
    
    @objc dynamic var login = ""
    @objc dynamic var password = ""
    
    
    override static func primaryKey() -> String? {
        return "login"
    }
    
    convenience init (login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }
}


