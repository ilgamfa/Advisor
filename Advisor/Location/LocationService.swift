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
    
    func getUserLocation(completion: (_ lat: String, _ lon: String) -> Void) {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        guard let currentLocation = locationManager.location else { return }
        let latitude = String(format: "%.4f", currentLocation.coordinate.latitude)
        let longitude = String(format: "%.4f", currentLocation.coordinate.longitude)
        completion(latitude, longitude)
        
        
    }
}
