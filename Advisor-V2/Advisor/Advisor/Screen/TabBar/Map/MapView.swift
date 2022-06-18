//
//  MapView.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import UIKit
import MapKit
enum MapFlow {
    case all
    case category
    case oneObject
    case userLocation
}

protocol MapViewProtocol: AnyObject {
    func showUserLocation()
    func showAlertError(message: String, title: String?, url:String?)
    func pinAnnotation(annotations: [Annotation])
    func configureSettingsWith(indexMapType: Int, indexCollectionType: Int, indexRateType: String)
}

class MapView: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var settingsButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var locationButton: UIButton!
    
    var presenter: MapPresenterProtocol?
    var configurator = MapConfigurator()
    var locationManager = CLLocationManager()
    var rate: String?
    var kind: String?
    var model: AttractionDetail?
    var mapFlow = MapFlow.all
    let settings = SettingsView(nibName: SettingsView.identifier, bundle: nil)
    
    var span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        configurator.configure(view: self)
        configureButtons()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if navigationController?.viewControllers.last?.nibName == "DetailView" {
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupMap()
    }
    
    public func setupMapWith(rate: String, kind: String) {
        presenter?.presentMapWith(rate: rate, kind: kind)
    }
    
    private func setupMap() {
        let indexMapType = UserDefaults.standard.integer(forKey: "MapViewTypeIndex")
        settings.selectedIndexMapType = indexMapType
        configureMapTypeWith(indexMapType: indexMapType)
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        switch mapFlow {
        case .all:
            presenter?.presentMap()
            settingsButton.isHidden = false
        case .category:
            if let rate = rate, let kind = kind {
                presenter?.presentMapWith(rate: rate, kind: kind)
            }
        case .oneObject:
            if let model = model {
                presenter?.presentOneObject(model: model)
            }
        case .userLocation:
            return
        }
    }
    
    private func configureButtons() {
        [settingsButton, minusButton, plusButton, locationButton].forEach { buttons in
            buttons?.layer.cornerRadius = 6
        }
        settings.delegate = self
    }
    
    private func zoomMap(isZoomOut: Bool) {
        var region: MKCoordinateRegion = mapView.region
        if isZoomOut {
            region.span.latitudeDelta *= 2.0
            region.span.longitudeDelta *= 2.0
        } else {
            region.span.latitudeDelta /= 2.0
            region.span.longitudeDelta /= 2.0
        }
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func settingsButtonDidTap(_ sender: Any) {
       
        if #available(iOS 15.0, *) {
            if let presentationController = settings.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium(), .large()]
            }
        } else {
            settings.modalPresentationStyle = .formSheet
        }
        present(settings, animated: true)
    }
    
    @IBAction func plusButtonDidTap(_ sender: Any) {
        zoomMap(isZoomOut: false)
    }
    
    @IBAction func minusButtonDidTap(_ sender: Any) {
        zoomMap(isZoomOut: true)
    }
    @IBAction func locationButtonDidTap(_ sender: Any) {
        mapFlow = .userLocation
        locationManager.startUpdatingLocation()
    }
}

extension MapView: MapViewProtocol {
    func showUserLocation() {
        mapView.showsUserLocation = true
    }
    
    func showAlertError(message: String, title: String?, url:String?) {
        let alert = UIAlertController.init(title: "Something went wrong", message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { alert in
            if let url = URL(string: url!) {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url,options: [:], completionHandler:  nil)
                }
            }
        }
        alert.addAction(settingsAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func pinAnnotation(annotations: [Annotation]) {
        if !mapView.annotations.isEmpty {
            mapView.removeAnnotations(mapView.annotations)
        }
        mapView.addAnnotations(annotations)
    }
    
    func configureMapTypeWith(indexMapType: Int) {
        switch indexMapType {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .standard
        }
    }
    
    func configureSettingsWith(indexMapType: Int, indexCollectionType: Int, indexRateType: String) {
        UserDefaults.standard.set(indexMapType, forKey: "MapViewTypeIndex")
        configureMapTypeWith(indexMapType: indexMapType)
        presenter?.presentMapWith(rate: indexRateType, kind: collectionTypes[indexCollectionType])
    }
}

extension MapView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        var coordinateRegion = MKCoordinateRegion(center: location.coordinate, span: span)
        if let model = model, mapFlow == .oneObject {
            coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: model.point!.lat, longitude: model.point!.lon), span: span)
        }
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true
        locationManager.stopUpdatingLocation()
    }
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? Annotation else { return }
        mapFlow == .oneObject ? presenter?.dismissScreen() : presenter?.presentDetailView(xid: annotation.xid)
    }
}
