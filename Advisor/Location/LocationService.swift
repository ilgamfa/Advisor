//
//  LocationManager.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 03.10.2021.
//

import Foundation
import MapKit

protocol ShowAlertLocationDelegate: AnyObject {
    func showAlertLocation(title: String, message: String, url: String)
}

class LocationService {
    weak var delegate: ShowAlertLocationDelegate?
    
    let locationManager = CLLocationManager()
    
    
    func checkLocationEnabled() {
        let status = locationManager.authorizationStatus
        
        if !CLLocationManager.locationServicesEnabled() {
            delegate?.showAlertLocation(title: "Device location is unavailable", message: "Do you want to turn on?", url: "App-Prefs:root=LOCATION_SERVICES")
        }
        else if status != .authorizedAlways && status != .authorizedWhenInUse {
            delegate?.showAlertLocation(title: "Advisor needs permission access to your location", message: "Please turn on 'Always' or 'When in use'\n In Location Services", url: UIApplication.openSettingsURLString)
        }
        else {
            setupManager()
        }
    }
    
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func getUserLocation(completion: (_ lat: String, _ lon: String) -> Void) {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        guard let currentLocation = locationManager.location else { return }
        let latitude = String(format: "%.4f", currentLocation.coordinate.latitude)
        let longitude = String(format: "%.4f", currentLocation.coordinate.longitude)
        completion(latitude, longitude)
        
        
    }
}
