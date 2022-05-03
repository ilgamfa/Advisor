//
//  DetailInteractor.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 02.05.2022.
//

import Foundation
import Moya
import Alamofire

protocol DetailInteractorProtocol {
    func fetchDetailData(xid: String, completion: @escaping (Result<AttractionDetail, MoyaError>) -> Void)
    func downloadImage(imageSource: String, completion: @escaping (Result<UIImage, AFError>) -> Void)
}

class DetailInteractor {
    weak var presenter: DetailPresenterProtocol?
    var tripApi: TripApiNetworkProtocol?
    
    init(presenter: DetailPresenterProtocol, tripApi: TripApiNetworkProtocol) {
        self.presenter = presenter
        self.tripApi = tripApi
    }
}

extension DetailInteractor: DetailInteractorProtocol {
    func fetchDetailData(xid: String, completion: @escaping (Result<AttractionDetail, MoyaError>) -> Void) {
        tripApi?.fetchDetailData(xid: xid) { result in
            switch result {
            case .success(let detail):
                completion(.success(detail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(imageSource: String, completion: @escaping (Result<UIImage, AFError>) -> Void) {
        tripApi?.fetchImage(source: imageSource, completion: { result in
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
