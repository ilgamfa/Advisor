//
//  FeedInteractor.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation
import Moya

protocol FeedInteractorProtocol: AnyObject {
    func fetchTableData(rate: String, kind: String, completion: @escaping (Result<[Attraction], MoyaError>) -> Void)
}

class FeedInteractor: FeedInteractorProtocol {
    
    weak var presenter: FeedPresenterProtocol?
    var tripApi: TripApiNetworkProtocol?
    var locationService: LocationService?
    var latitude = ""
    var longitude = ""
    
    init(presenter: FeedPresenterProtocol, tripApi: TripApiNetworkProtocol, locationService: LocationService) {
        self.presenter = presenter
        self.tripApi = tripApi
        self.locationService = locationService  

        latitude = locationService.getCurrentLocation().latitude
        longitude = locationService.getCurrentLocation().longitude
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

