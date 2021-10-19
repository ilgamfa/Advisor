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
        mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)), animated: true)
        mapView.showsUserLocation = true
        locationService.locationManager.stopUpdatingLocation()
        
        attractionViewModel.fetchData(rate: "2h", kinds: "interesting_places") { [self] in
            DispatchQueue.main.async {
                self.attractionViewModel.setAnnotation(mapView: mapView)
            }
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
