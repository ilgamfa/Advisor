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
        
//        locationService.isLocationServiceEnabled(mapView)
//        locationService.setLocationManager()
        
        attractionViewModel.fetchData(rate: "2h", kinds: "interesting_places") { [self] in
            DispatchQueue.main.async {
                self.attractionViewModel.setAnnotation(mapView: mapView)
            }
        }
        locationService.locationManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        attractionViewModel.fetchData { [self] in
//            DispatchQueue.main.async {
//                self.attractionViewModel.setAnnotation(mapView: mapView)
//            }
//
//        }
    }
   
    
    @IBAction func myLocationButtonDidTap(_ sender: UIButton) {
        locationService.locationManager.startUpdatingLocation()
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        mapView.showsUserLocation = true
        locationService.locationManager.stopUpdatingLocation()

    }
}
