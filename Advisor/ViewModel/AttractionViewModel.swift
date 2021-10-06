//
//  AttractionViewModel.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 30.09.2021.
//

import Foundation
import MapKit
import CoreLocationUI

class AttractionViewModel {
    private var networkManager = NetworkService()
    var attractionData = [Attraction]()
    var annotationData = [Annotation]()
    
    func fetchData(completion: @escaping () -> ()) {
        networkManager.fetchData { result in
            switch result {
            case .success(let attractions):
                self.attractionData = attractions
                completion()
            case .failure(let error):
                print("Error procession json data: \(error)")
            }
        }
    }
    
    
    func fetchGeoJsonData(completion: @escaping () -> ()) {
        networkManager.fetchGeoJsonData { result in
            switch result {
            case .success(let annotations):
                self.annotationData = annotations
                completion()
            case .failure(let error):
                print("Error procession Geo Json data: \(error)")
            }
        }
    }
    
    
    
    func setAnnotation(mapView: MKMapView) {
        for attraction in attractionData {
            let annotation = MKPointAnnotation()
            annotation.title = attraction.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: attraction.point.lat, longitude: attraction.point.lon)
            mapView.addAnnotation(annotation)
        }
    }
    
    
    func numbersOfRowsInSection(section: Int) -> Int {
        if attractionData.count != 0 {
            return attractionData.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Attraction {
        return attractionData[indexPath.row]
    }
    
}
