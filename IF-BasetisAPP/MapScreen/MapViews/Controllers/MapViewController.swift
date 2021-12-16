//
//  MapViewController.swift
//  IF-BasetisAPP
//
//  Created by Fatima Syed on 17/09/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: MapViewModel = MapViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setDelegate(locationManagerDelegate: self)
        addMapAnnotations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.requestLocationPermission { (authorized) in
            if authorized {
                self.viewModel.startUpdatingLocation()
            } else {
                self.showAlertUbication()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.stopUpdateLocation()
    }

    func landOnMap (_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        setCenter(coordinate, animated: true)
    }
    
    func setCenter(_ coordinate: CLLocationCoordinate2D, animated: Bool){
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func showAlertUbication() {
        let alert = UIAlertController(title: viewModel.constants.alertLocationTitle, message: viewModel.constants.alertLocationMessage, preferredStyle: UIAlertController.Style.alert)
        let settingsAction = UIAlertAction(title: viewModel.constants.alertSettingsTitle, style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                }
        }
        alert.addAction(settingsAction)
        alert.addAction(UIAlertAction(title: viewModel.constants.alertActionOK, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - LocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            viewModel.stopUpdateLocation()
            landOnMap(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(viewModel.constants.errorString)
    }
    
    // MARK: Map Annotations
    
    func addMapAnnotations() {
        for cinema in viewModel.getAllCinemas() {
            let annotation = MKPointAnnotation()
            annotation.title = cinema.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude )
            mapView.addAnnotation(annotation)
        }
    }
}
