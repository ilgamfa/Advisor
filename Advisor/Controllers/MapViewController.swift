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
    private var locationService = LocationService()
    
    @IBOutlet weak var mapView: MKMapView!

 
    override func viewDidLoad() {
        super.viewDidLoad()
        attractionViewModel.fetchData { [self] in
            self.attractionViewModel.setAnnotation(mapView: mapView)
        }
        
        locationService.locationManager.delegate = self
//        locationManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationService.isLocationServiceEnabled(mapView)
        locationService.setLocationManager()
    }
   
    
    @IBAction func myLocationButtonDidTap(_ sender: CLLocationButton) {
        locationService.locationManager.startUpdatingLocation()
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        mapView.showsUserLocation = true
        locationService.locationManager.stopUpdatingLocation()

    }
}
