//
//  DBClass.swift
//  Tracker
//
//  Created by Mikhail on 01/10/2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import Foundation
import RealmSwift

final class DBUserClass {
    
    func saveUserData( _ data: User)  {
        
        do {
            let realm = try? Realm()
            realm?.beginWrite()
            realm?.add(data, update: true)
            try? realm?.commitWrite()
        }

        catch {
            fatalError("Realm error")
        }
    }
    
    func loadUserData() -> [User] {
        
        var returnData = [User]()
        
        do {
            let realm = try? Realm()
            if let users = realm?.objects(User.self) {
                returnData = Array(users)
            }
            return returnData
            
        }
        catch {
            fatalError("Realm error")
        }
    }
    
    func deleteUserDataForKey(_ key: String) {
        
        do {
            let realm = try? Realm()
            realm?.beginWrite()
            guard let object = realm?.object(ofType: User.self, forPrimaryKey: key) else {return}
            realm?.delete(object)
            try? realm?.commitWrite()
        }
    }

}
