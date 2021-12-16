//
//  mapViewModel.swift
//  IF-BasetisAPP
//
//  Created by Fatima Syed on 21/09/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation
import CoreLocation

class MapViewModel {
    private let dataProvider = DataProvider()
    
    struct Constants {
        var alertLocationTitle = "locationNotAvailableAlert".localized()
        var alertLocationMessage = "permissionNotGivenMessage".localized()
        var alertSettingsTitle = "settingsTitle".localized()
        var alertActionOK = "okAlert".localized()
        var errorString = "errorMessage".localized()
        var cinemaJSON =  "cinemasTitle".localized()
    }
    
    let constants = Constants()
    
    func setDelegate(locationManagerDelegate: CLLocationManagerDelegate) {
        LocationManager.shared.setDelegate(delegate: locationManagerDelegate)
    }
    
    func requestLocationPermission(completion: @escaping (Bool) -> Void) {
        completion(LocationManager.shared.requestPermission())
    }
    
    func startUpdatingLocation() {
        LocationManager.shared.startUpdateLocation()
    }
    
    func stopUpdateLocation() {
        LocationManager.shared.stopUpdatingLocation()
    }
    
    // MARK: DataProvider
    
    func getAllCinemas() -> [Cinema] {
        return dataProvider.loadLocalJson(constants.cinemaJSON)
    }
}
