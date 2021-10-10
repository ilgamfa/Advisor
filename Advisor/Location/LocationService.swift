//
//  LocationManager.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 03.10.2021.
//

import Foundation
import MapKit

class LocationService {
    let locationManager = CLLocationManager()
    
    private func locationManagerDidChangeAuthorization(_ manager: CLLocationManager, _ mapView: MKMapView) {
        switch manager.authorizationStatus {

        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            print("authorized always")

        case .notDetermined:
            print("authorized not determind")
            
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
            

        case .denied:
            print("authorized denied")
            displayLocationAlert()

        case .restricted:
            print("authorized restricted")
            displayLocationAlert()
        @unknown default:
            break
        }
    }
    
    func getUserLocation(completion: (_ lat: String, _ lon: String) -> Void) {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
            guard let currentLocation = locationManager.location else { return }
            let latitude = String(format: "%.4f", currentLocation.coordinate.latitude)
            let longitude = String(format: "%.4f", currentLocation.coordinate.longitude)
            
            completion(latitude, longitude)
        }
    }
    
    func setLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func isLocationServiceEnabled(_ mapView: MKMapView) {
        if CLLocationManager.locationServicesEnabled() {
            locationManagerDidChangeAuthorization(locationManager, mapView)
        }
        else {
            displayLocationAlert()
        }
    }
    
    
    func displayLocationAlert() {
        let message = "This app needs location access permissions \n Turn on the geolocation service in the privacy settings"
        
        let alert = UIAlertController(title: "Location service is disabled", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
