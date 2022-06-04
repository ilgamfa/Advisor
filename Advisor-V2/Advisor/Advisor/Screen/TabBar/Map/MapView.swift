//
//  MapView.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import UIKit
import MapKit

protocol MapViewProtocol: AnyObject {
    func showUserLocation()
    func showAlertError(message: String, title: String?, url:String?)
    func pinAnnotation(annotations: [Annotation])
}

class MapView: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var settingsButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    
    var presenter: MapPresenterProtocol?
    var configurator = MapConfigurator()
    var locationManager = CLLocationManager()
    var rate: String?
    var kind: String?
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
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        if let rate = rate, let kind = kind {
            presenter?.presentMapWith(rate: rate, kind: kind)
        } else {
            presenter?.presentMap()
        }
    }
    
    private func configureButtons() {
        [settingsButton, minusButton, plusButton].forEach { buttons in
            buttons?.layer.cornerRadius = 6
        }
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
        let settings = SettingsView(nibName: SettingsView.identifier, bundle: nil)
        if #available(iOS 15.0, *) {
            if let presentationController = settings.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium()]
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
        mapView.addAnnotations(annotations)
    }
}

extension MapView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true
        locationManager.stopUpdatingLocation()        
    }
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? Annotation else { return }
        presenter?.presentDetailView(xid: annotation.xid)
    }
}
