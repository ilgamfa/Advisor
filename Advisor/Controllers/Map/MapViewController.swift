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
    
    @IBOutlet weak var locationView: UIView!
    
    // MARK: Private
    private let attractionViewModel = AttractionViewModel()
    private var attractionData = [Attraction]()
    private var locationService = LocationService()
    
    // MARK: Outlet
    @IBOutlet private weak var mapView: MKMapView!

    // MARK: Public
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var nameTitle: String = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()
        locationView.layer.borderWidth = 1
        locationView.layer.borderColor = UIColor.lightGray.cgColor
        locationView.layer.cornerRadius = 5
        locationView.layer.masksToBounds = true
        
        locationService.delegate = self
        locationService.locationManager.delegate = self
        
        locationService.checkLocationEnabled()
        locationService.locationManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationService.checkLocationEnabled()
    }

    @IBAction func myLocationButtonDidTap(_ sender: UIButton) {
        locationService.locationManager.startUpdatingLocation()
    }
 
}

// MARK: CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, span: span)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true
        locationService.locationManager.stopUpdatingLocation()
        
        if latitude == 0.0 {
            attractionViewModel.fetchData(rate: "2h", kinds: "interesting_places") { [self] in
                DispatchQueue.main.async {
                    self.attractionViewModel.setAnnotation(mapView: mapView)
                }
            }
        }
        else {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            annotation.title = nameTitle
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, span: span)
            
            mapView.setRegion(coordinateRegion, animated: true)
            mapView.addAnnotation(annotation)
        }
        
        
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationService.checkLocationEnabled()
    }
}

// MARK: ShowAlertLocationDelegate
extension MapViewController: ShowAlertLocationDelegate {
    func showAlertLocation(title: String, message: String, url: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { alert in
            if let url = URL(string: url) {
                UIApplication.shared.open(url,options: [:], completionHandler:  nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
