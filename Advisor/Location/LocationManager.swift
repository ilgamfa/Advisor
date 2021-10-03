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

        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true

        case .restricted, .denied:
            displayLocationAlert()

        @unknown default:
            break
        }
    }
    
    func setLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
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
        let message = "This awesome app needs authorization to do some cool stuff with the map"
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
