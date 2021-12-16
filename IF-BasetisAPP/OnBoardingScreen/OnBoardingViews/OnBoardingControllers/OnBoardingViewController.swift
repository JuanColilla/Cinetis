//
//  OnBoardingViewController.swift
//  IF-BasetisAPP
//
//  Created by Nekane Pardo on 07/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit
import CoreLocation

class WelcomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    // MARK: Properties
    let viewModel = OnBoardingViewModel()
    var permissionRequested: Bool = false

    // MARK: View
    @IBOutlet weak var welcomeTitleLabel: UILabel!
    
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var locationTextBodyLabel: UILabel!
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var cameraTitleLabel: UILabel!
    @IBOutlet weak var cameraTextBodyLabel: UILabel!
    
    @IBOutlet weak var photoLibraryView: UIView!
    @IBOutlet weak var photoLibraryImageView: UIImageView!
    @IBOutlet weak var photoLibraryTitleLabel: UILabel!
    @IBOutlet weak var photoLibraryTextBodyLabel: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        if permissionRequested {
            self.dismiss(animated: true)
        } else {
            continueButton.setTitle(viewModel.constants.continueButtonText, for: .normal)
            requestAllPermissions()
            continueButton.isEnabled = false
            continueButton.backgroundColor = .gray
        }
    }
    
    // MARK:  APP LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setDelegate(locationManagerDelegate: self)
        setUpUI()
        localizeScreen()
    }
    
    // MARK: Request Permissions
    func requestAllPermissions() {
        continueButton.isEnabled = false
        requestCameraPermission {
            if self.viewModel.isCameraAuthorized() {
            DispatchQueue.main.async {
                self.colorStackView(view: self.cameraView, imageView: self.cameraImageView, label: self.cameraTitleLabel, color: UIColor.accentColor())
                }
            }
            self.requestPhotoLibraryPermission {
                if self.viewModel.isPhotoLibraryAuthorized() {
                    DispatchQueue.main.async {
                        self.colorStackView(view: self.photoLibraryView, imageView: self.photoLibraryImageView, label: self.photoLibraryTitleLabel, color: UIColor.accentColor())
                    }
                }
                self.requestLocationPermission {
                    self.permissionRequested = true
                }
            }
        }
    }
    
    func requestCameraPermission(completion: @escaping () -> ()) {
        viewModel.requestCameraPermission { _ in
            completion()
        }
    }
    
    func requestPhotoLibraryPermission(completion: @escaping () -> ()) {
        viewModel.requestPhotoLibraryPermission { _ in
            completion()
        }
    }
    
    func requestLocationPermission(completion: @escaping () -> ()) {
        viewModel.requestLocationPermission { _ in
            completion()
        }
        
    }

    // MARK: setUpUI
    func setUpUI() {
        colorStackView(view: locationView, imageView: locationImageView, label: locationTitleLabel, color: UIColor.systemGray)
        colorStackView(view: cameraView, imageView: cameraImageView, label: cameraTitleLabel, color: UIColor.systemGray)
        colorStackView(view: photoLibraryView, imageView: photoLibraryImageView, label: photoLibraryTitleLabel, color: UIColor.systemGray)
        setUpRoundedCorner(view: continueButton)
    }
    
    func colorStackView(view: UIView, imageView: UIView, label: UILabel, color: UIColor) {
        setUpBorderOutline(view: view, color: color)
        imageView.tintColor = color
        label.textColor = color
    }
    
    func setUpBorderOutline(view: UIView, color: UIColor) {
        setUpRoundedCorner(view: view)
        view.layer.borderWidth = 1
        view.layer.borderColor = color.cgColor
    }
    
    func setUpRoundedCorner(view: UIView) {
        view.layer.cornerRadius = 10
    }
   
    
    // MARK: Localize
    func localizeScreen() {
        welcomeTitleLabel.text = viewModel.constants.title
        locationTitleLabel.text = viewModel.constants.locationTitle
        locationTextBodyLabel.text = viewModel.constants.locationBodyText
        cameraTitleLabel.text = viewModel.constants.cameraTitle
        cameraTextBodyLabel.text = viewModel.constants.cameraBodyText
        photoLibraryTitleLabel.text = viewModel.constants.photoLibraryTitle
        photoLibraryTextBodyLabel.text = viewModel.constants.photoLibraryBodyText
        continueButton.setTitle(viewModel.constants.requestPermissionsButtonText, for: .normal)
    }
    
    // MARK: LocationDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if permissionRequested && self.viewModel.isMapAuthorized() {
            DispatchQueue.main.async {
                self.colorStackView(view: self.locationView, imageView: self.locationImageView, label: self.locationTitleLabel, color: UIColor.accentColor())
            }
        }
        DispatchQueue.main.async {
            self.continueButton.isEnabled = true
            self.continueButton.backgroundColor = UIColor.accentColor()
        }
    }
}
