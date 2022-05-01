//
//  FeedInteractor.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation

protocol FeedInteractorProtocol: AnyObject {
    func fetchTableData(rate: String, kind: String, completion: @escaping (Result<[Attraction], Error>) -> Void)
}

class FeedInteractor: FeedInteractorProtocol {
    
    weak var presenter: FeedPresenterProtocol?
    
    private var networkService = NetworkService()
    
    init(presenter: FeedPresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetchTableData(rate: String, kind: String, completion: @escaping (Result<[Attraction], Error>) -> Void) {
        networkService.fetchData(rate: rate, kinds: kind) { result in
            switch result {
            case .success(let attraction):
                completion(.success(attraction))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

