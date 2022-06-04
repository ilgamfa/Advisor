//
//  LocationService.swift
//  Advisor_V2
//
//  Created by Ilgam Akhmatdinov on 02.06.2022.
//

import Foundation
import CoreLocation

class LocationService {
    let locationManager = CLLocationManager()
    
    struct CurrentLocation {
        var latitude: String
        var longitude : String
    }
    
    func getCurrentLocation() -> CurrentLocation {
        guard let currentLocation = locationManager.location else { return CurrentLocation(latitude: "", longitude: "")}
        let latitude = String(format: "%.4f", currentLocation.coordinate.latitude)
        let longitude = String(format: "%.4f", currentLocation.coordinate.longitude)
        return CurrentLocation(latitude: latitude, longitude: longitude)
    }
}
