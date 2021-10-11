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
    private var networkService = NetworkService()
    private var attractionData = [Attraction]()
    var detailImage: UIImage?
    var attractionDetail: AttractionDetail?
    
    func downloadData(imageUrl: String, completion: @escaping () -> ()) {
        
        networkService.downloadImage(imageURL: imageUrl) { result in
            switch result {
            case .success(let image):
                self.detailImage = UIImage(data: image)
                completion()
            case .failure(let error):
                print("Error procession json data: \(error)")
            }
        }
    }
    
    
    
    func fetchData(kinds: String, completion: @escaping () -> ()) {
        
        networkService.fetchData(kinds: kinds) { result in
            switch result {
            case .success(let attractions):
                self.attractionData = attractions
                completion()
            case .failure(let error):
                print("Error procession json data: \(error)")
            }
        }
    }
    
    
    func fetchDetailData(xid: String, completion: @escaping () -> ()) {
        networkService.fetchDetailsData(xid: xid) { result in
            switch result {
            case .success(let detail):
                self.attractionDetail = detail
                completion()
            case .failure(let error):
                print("Error procession json data: \(error)")
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
