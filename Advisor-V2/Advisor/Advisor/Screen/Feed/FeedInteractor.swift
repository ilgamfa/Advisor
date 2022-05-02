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
    
    init(presenter: FeedPresenterProtocol, tripApi: TripApiNetworkProtocol) {
        self.presenter = presenter
        self.tripApi = tripApi
    }
    
    func fetchTableData(rate: String, kind: String, completion: @escaping (Result<[Attraction], MoyaError>) -> Void) {
        tripApi?.fetchData(rate: rate, kind: kind, completion: { result in
            switch result {
            case .success(let attraction):
                completion(.success(attraction))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

