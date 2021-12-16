//
//  PermissionManager.swift
//  IF-BasetisAPP
//
//  Created by Nekane Pardo on 18/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation
import AVFoundation
import Photos


/// PermissionManager requests Camera and PhotoLibrary permissions if they're not determined.
class PermissionManager {
    // MARK: Camera
    func requestCameraPermission(completion: @escaping (Bool) -> ()) {
        AVCaptureDevice.requestAccess(for: .video) { authorized in
            completion(authorized)
        }
    }

    func requestCameraNotDeterminedPermission() {
        AVCaptureDevice.requestAccess(for: .video) { _ in }
    }
    
    func checkCameraAuthorization() -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            requestCameraNotDeterminedPermission()
        case .authorized:
            return true
        case .restricted, .denied:
            return false
        default:
            return false
        }
        return false
    }
    
    // MARK: Photo Library
    func requestPhotoLibraryPermission(completion: @escaping (Bool) -> ()) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { authStatus in
            let authorized = authStatus == .authorized || authStatus == .limited
                completion(authorized)
            }
    }
    
    func checkPhotoLibraryAuthorization() -> Bool {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .notDetermined:
            requestPhotoLibraryNotDeterminedPermission()
        case .limited, .authorized:
            return true
        case .restricted, .denied:
            return false
        default:
            return false
        }
        return false
    }
    
    func requestPhotoLibraryNotDeterminedPermission() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { _ in }
    }

}
