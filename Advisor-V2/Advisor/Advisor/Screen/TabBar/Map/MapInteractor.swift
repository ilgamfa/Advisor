//
//  MapInteractor.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import UIKit
import Moya

protocol MapInteractorProtocol: AnyObject {
    func fetchMapObjects(rate: String, kind: String, completion: @escaping (Result<[Attraction], MoyaError>) -> Void)
}

class MapInteractor: MapInteractorProtocol {
    weak var presenter: MapPresenterProtocol?
    var tripApi: TripApiNetworkProtocol?
    var locationService: LocationService?
    var latitude = ""
    var longitude = ""
    
    init(presenter: MapPresenterProtocol, tripApi: TripApiNetworkProtocol, locationService: LocationService) {
        self.presenter = presenter
        self.tripApi = tripApi
        self.locationService = locationService
        
        latitude = locationService.getCurrentLocation().latitude
        longitude = locationService.getCurrentLocation().longitude
    }

    func fetchMapObjects(rate: String, kind: String, completion: @escaping (Result<[Attraction], MoyaError>) -> Void) {
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
