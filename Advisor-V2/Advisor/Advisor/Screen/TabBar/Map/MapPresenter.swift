//
//  MapPresenter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation
import MapKit
import CoreLocation

protocol MapPresenterProtocol: AnyObject {
    func presentMap()
    func presentMapWith(rate: String, kind: String)
}

class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    var interactor: MapInteractorProtocol?
    var router: MapRouterProtocol?
    
    private var locationManager = CLLocationManager()
    
    init(view: MapViewProtocol) {
        self.view = view
    }
    
    private func checkLocationEnabled(rate: String, kind: String) {
        let status = locationManager.authorizationStatus
        
        if !CLLocationManager.locationServicesEnabled() {
            view?.showAlertError(message: "Do you want to turn on?", title: "Device location is unavailable", url: "App-Prefs:root=LOCATION_SERVICES")
        }
        else if status != .authorizedAlways && status != .authorizedWhenInUse {
            view?.showAlertError(message: "Please turn on 'Always' or 'When in use'\n In Location Services", title: "Advisor needs permission access to your location", url: UIApplication.openSettingsURLString)
        }
        else {
            setupManager()
            presentAnnotations(rate: rate, kind: kind)
        }
    }
    
    private func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func presentAnnotations(rate: String, kind: String) {
        interactor?.fetchMapObjects(rate: rate, kind: kind, completion: { result in
            var pins = [Annotation]()
            switch result {
            case .success(let attraction):
                attraction.forEach { attraction in
                    pins.append(Annotation(title: attraction.name,
                                           locationName: attraction.name,
                                           discipline: attraction.kinds,
                                           coordinate: CLLocationCoordinate2D(latitude: attraction.point.lat,
                                                                              longitude: attraction.point.lon)))
                }
                self.view?.pinAnnotation(annotations: pins)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        })
    }
    
    func presentMap() {
        checkLocationEnabled(rate: "3", kind: "interesting_places")
    }
    func presentMapWith(rate: String, kind: String) {
        checkLocationEnabled(rate: rate, kind: kind)
    }
}
