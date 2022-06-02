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
}

class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    var interactor: MapInteractorProtocol?
    var router: MapRouterProtocol?
    
    private var locationManager = CLLocationManager()
    
    init(view: MapViewProtocol) {
        self.view = view
    }
    
    private func checkLocationEnabled() {
        let status = locationManager.authorizationStatus
        
        if !CLLocationManager.locationServicesEnabled() {
            view?.showAlertError(message: "Do you want to turn on?", title: "Device location is unavailable", url: "App-Prefs:root=LOCATION_SERVICES")
        }
        else if status != .authorizedAlways && status != .authorizedWhenInUse {
            view?.showAlertError(message: "Please turn on 'Always' or 'When in use'\n In Location Services", title: "Advisor needs permission access to your location", url: UIApplication.openSettingsURLString)
        }
        else {
            setupManager()
            presentAnnotations()
        }
    }
    
    private func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func presentMap() {
        checkLocationEnabled()
    }
    
    func presentAnnotations() {
        interactor?.fetchMapObjects(rate: "1h", kind: "interesting_places", completion: { result in
            switch result {
            case .success(let attraction):
                print(attraction.last?.point)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        })
    }
  
}
