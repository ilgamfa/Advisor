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
    
    // MARK: Private
    private let attractionViewModel = AttractionViewModel()
    private var attractionData = [Attraction]()
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!

 
    override func viewDidLoad() {
        super.viewDidLoad()
        attractionViewModel.fetchData { [self] in
            self.attractionViewModel.setAnnotation(mapView: mapView)
        }
        
        locationManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isLocationServiceEnabled()
        setLocationManager()
    }
   
    
    @IBAction func myLocationButtonDidTap(_ sender: CLLocationButton) {
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Private functions
    private func setLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func isLocationServiceEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManagerDidChangeAuthorization(locationManager)
        }
        else {
            displayLocationAlert()
        }
    }
    
     func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
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
    
    private func displayLocationAlert() {
        
        let message = "This awesome app needs authorization to do some cool stuff with the map"
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
        
    }
    
//    private func setAnnotation(attractions:[Attraction]) {
//        for attraction in attractions {
//
//            let annotation = MKPointAnnotation()
//
//            annotation.title = attraction.name
//
//            annotation.coordinate = CLLocationCoordinate2D(latitude: attraction.point.lat, longitude: attraction.point.lon)
//
//            mapView.addAnnotation(annotation)
//        }
//    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        mapView.showsUserLocation = true
        locationManager.stopUpdatingLocation()

    }
}
