//
//  LocationManager.swift
//  IF-BasetisAPP
//
//  Created by Fatima Syed on 18/09/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation
import CoreLocation

/// This class is made to control features of the MapView. It requests the permission to get access to the user location, it updates the location and also focuses on the desiredAccuracy.
class LocationManager {
    
    private let manager = CLLocationManager()
    
    static let shared = LocationManager()
    
    private init () {
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func setDelegate(delegate: CLLocationManagerDelegate) {
        manager.delegate = delegate
    }
    
    func requestPermission() -> Bool {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
            return true
        case .restricted, .denied:
            return false
        default:
            return false
        }
        return false
    }

    func startUpdateLocation() {
        manager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }
}
