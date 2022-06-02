//
//  FeedInteractor.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation
import Moya
import CoreLocation

protocol FeedInteractorProtocol: AnyObject {
    func fetchTableData(rate: String, kind: String, completion: @escaping (Result<[Attraction], MoyaError>) -> Void)
}

class FeedInteractor: FeedInteractorProtocol {
    
    weak var presenter: FeedPresenterProtocol?
    var tripApi: TripApiNetworkProtocol?
    let locationManager = CLLocationManager()
    var latitude = ""
    var longitude = ""
    
    init(presenter: FeedPresenterProtocol, tripApi: TripApiNetworkProtocol) {
        self.presenter = presenter
        self.tripApi = tripApi
        getCurrentLocation()
    }
    
    private func getCurrentLocation() {
        guard let currentLocation = locationManager.location else { return }
        latitude = String(format: "%.4f", currentLocation.coordinate.latitude)
        longitude = String(format: "%.4f", currentLocation.coordinate.longitude)
    }
    
    func fetchTableData(rate: String, kind: String, completion: @escaping (Result<[Attraction], MoyaError>) -> Void) {
        tripApi?.fetchData(rate: rate, kind: kind, lat: latitude, lon: longitude, completion: { result in
            switch result {
            case .success(let attraction):
                completion(.success(attraction))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

