//
//  DBCoordinatesClass.swift
//  Tracker
//
//  Created by Mikhail on 02/10/2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import Foundation
import RealmSwift



final class DBCoordinatesClass {
    
    func saveData(_ data: Coordinates) {
        
        do {
            let realm = try? Realm()
            realm?.beginWrite()
            realm?.add(data)
            try realm?.commitWrite()
        }
        catch {
            print(error)
        }
        
    }
    
    func loadData() -> [Coordinates] {
        var returnData = [Coordinates]()
        do {
            
            let realm = try? Realm()
            if let coordinates = realm?.objects(Coordinates.self) {
                returnData = Array(coordinates)
            }
            return returnData
            
        }
        catch {
            print(error)
        }
    }
    
    func deleteData() {
        do {
            let realm = try? Realm()
            realm?.beginWrite()
            realm?.deleteAll()
            try realm?.commitWrite()
            
        }
        catch {
            print(error)
        }
    }
}
