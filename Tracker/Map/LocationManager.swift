//
//  LocationManager.swift
//  Tracker
//
//  Created by Mikhail on 04/10/2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift


final class LocationManager: NSObject {
    
    static let locationManager = LocationManager()
     var locationManager = CLLocationManager()
   
    var location = Variable<CLLocation?>(nil)
    
    private override init() {
        super.init()
        configureLocationManager()
    }

    
    func configureLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location.value = locations.last
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

