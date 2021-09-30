//
//  MapViewController.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.09.2021.
//

import UIKit
import MapKit
import CoreLocationUI

class MapViewController: UIViewController {

    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
    }
    
    @IBAction func myLocationButtonDidTap(_ sender: CLLocationButton) {
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
   
    
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        mapView.showsUserLocation = true
        locationManager.stopUpdatingLocation()

    }
}
