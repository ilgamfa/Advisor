//
//  NetworkManager.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 01.05.2022.
//

import Foundation
import Moya
import Alamofire
import AlamofireImage
import UIKit

protocol TripApiNetworkProtocol {
    func fetchData(rate: String, kind: String, lat: String, lon: String, completion: @escaping (Result<[Attraction], MoyaError>) -> Void)
    func fetchDetailData(xid: String, completion: @escaping (Result<AttractionDetail, MoyaError>) -> Void)
    func fetchImage(source: String, completion: @escaping (Result<UIImage, AFError>) -> Void)
}

class TripApiNetwork {
    
    private let provider = MoyaProvider<TripApiTargetType>()

    private let apiKey = "5ae2e3f221c38a28845f05b6811ec1c8612b2b7b55d46425957df5a4"
    private var radius = "100000"
    private var limit = "10000"
}

extension TripApiNetwork: TripApiNetworkProtocol {
    func fetchData(rate: String, kind: String, lat: String, lon: String, completion: @escaping (Result<[Attraction], MoyaError>) -> Void) {
        let target = TripApiTargetType.fetchData(rate: rate, kind: kind, radius: radius, longitude: lon, latitude: lat, limit: limit, apiKey: apiKey)
        provider.request(target) { result in
            switch result {
                
            case .success(let responce):
                do {
                    let model = try responce
                        .map([Attraction].self)
                    completion(.success(model))
                } catch {
                    completion(.failure(error as! MoyaError))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchDetailData(xid: String, completion: @escaping (Result<AttractionDetail, MoyaError>) -> Void) {
        let target = TripApiTargetType.fetchDetailData(xid: xid, apikey: apiKey)
        provider.request(target) { result in
            switch result {
            case .success(let responce):
                do {
                    let model = try responce
                        .map(AttractionDetail.self)
                    completion(.success(model))
                } catch {
                    completion(.failure(error as! MoyaError))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchImage(source: String, completion: @escaping (Result<UIImage, AFError>) -> Void) {
        AF.request(source).responseImage { response in
            switch response.result {
            case .success(let image):
                let size = CGSize(width: image.size.width * 3, height: image.size.height * 3)
                let scaled = image.af.imageRounded(withCornerRadius: 8, divideRadiusByImageScale: true).af.imageScaled(to: size)
                completion(.success(scaled))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
