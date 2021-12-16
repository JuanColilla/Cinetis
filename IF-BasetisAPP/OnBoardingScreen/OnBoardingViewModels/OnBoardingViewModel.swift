//
//  OnBoardingViewModel.swift
//  IF-BasetisAPP
//
//  Created by Nekane Pardo on 18/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

class OnBoardingViewModel {
    let permissionManager = PermissionManager()
    
    struct Constants {
        var title = "titleOnBoarding".localized()
        var locationTitle = "locationTitleOnBoarding".localized()
        var locationBodyText = "locationBodyTextOnBoarding".localized()
        var cameraTitle = "cameraTitleOnBoarding".localized()
        var cameraBodyText = "cameraBodyTextOnBoarding".localized()
        var photoLibraryTitle = "photoLibraryTitleOnBoarding".localized()
        var photoLibraryBodyText = "photoLibraryBodyTextOnBoarding".localized()
        var continueButtonText = "continueButtonTextOnBoarding".localized()
        var requestPermissionsButtonText = "requestPermissionButtonTextOnBoarding".localized()
    }
    
    let constants = Constants()
    
    // MARK: Map
    func setDelegate(locationManagerDelegate: CLLocationManagerDelegate) {
        LocationManager.shared.setDelegate(delegate: locationManagerDelegate)
    }
    func requestLocationPermission(completion: @escaping (Bool) -> ()) {
        completion(LocationManager.shared.requestPermission())
    }
    
    func isMapAuthorized() -> Bool {
        return LocationManager.shared.requestPermission()
    }
    
    // MARK: Camera
    func requestCameraPermission(completion: @escaping (Bool) -> ()) {
        return permissionManager.requestCameraPermission { authorized in
            completion(authorized)
        }
    }
    
    func isCameraAuthorized() -> Bool {
        return permissionManager.checkCameraAuthorization()
    }
    
    // MARK: Photo Library
    func requestPhotoLibraryPermission(completion: @escaping (Bool) -> ()) {
        permissionManager.requestPhotoLibraryPermission { authorized in
            completion(authorized)
        }
    }
    
    func isPhotoLibraryAuthorized() -> Bool {
        return permissionManager.checkPhotoLibraryAuthorization()
    }
    
}
