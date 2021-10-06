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
    private var annotations = [Annotation]()
    private var locationService = LocationService()
    
    // MARK: Outlet
    @IBOutlet private weak var mapView: MKMapView!

 
    override func viewDidLoad() {
        super.viewDidLoad()
        locationView.layer.borderWidth = 1
        locationView.layer.borderColor = UIColor.lightGray.cgColor
        locationView.layer.cornerRadius = 5
        locationView.layer.masksToBounds = true
        
        locationService.isLocationServiceEnabled(mapView)
        locationService.setLocationManager()
        
        //        attractionViewModel.fetchData { [self] in
        //            DispatchQueue.main.async {
        //                self.attractionViewModel.setAnnotation(mapView: mapView)
        //            }
        //        }
        
//        let artwork = Annotation(
//            name: "Hello",
//            xid: "123",
//            kinds: "Sculpture",
//            coordinate: CLLocationCoordinate2D(latitude: 55.1, longitude: 49.7))
//        mapView.addAnnotation(artwork)
//
//        mapView.delegate = self
//
    
        attractionViewModel.fetchGeoJsonData { [self] in
            
        }
        
        
        locationService.locationManager.delegate = self
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        attractionViewModel.fetchData { [self] in
//            DispatchQueue.main.async {
//                self.attractionViewModel.setAnnotation(mapView: mapView)
//            }
//
//        }
//    }
   
    
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


extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Annotation else { return nil }
        
        let reuseId = "annotation"
        
        var markerView: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            markerView = dequeuedView
            
        }
        else {
            markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            markerView.canShowCallout = true
            markerView.calloutOffset = CGPoint(x: -5, y: 5)
            markerView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return markerView
    }
}
