//
//  coordinatesClass.swift
//  Tracker
//
//  Created by Mikhail on 02/10/2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import Foundation
import RealmSwift



class Coordinates: Object {
    
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    
    convenience init(latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
    
}
