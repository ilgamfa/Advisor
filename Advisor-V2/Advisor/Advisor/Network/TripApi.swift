//
//  NetworkManager.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 01.05.2022.
//

import Foundation
import Moya
import UIKit

protocol TripApiNetworkProtocol {
    func fetchData(rate: String, kind: String, completion: @escaping (Result<[Attraction], MoyaError>) -> Void)
}

class TripApiNetwork {
    
    private let provider = MoyaProvider<TripApiTargetType>()
    
    //    private let locationService = LocationService()
        private let baseUrl = "https://api.opentripmap.com/0.1/en/places/"
        private var firstPartUrl = ""
        private var secondPartUrl = ""
        private var finalUrl = ""
        private let apiKey = "5ae2e3f221c38a28845f05b6811ec1c8612b2b7b55d46425957df5a4"
        private var radius = "100000"
        private var limit = "1000"
        private var latitude = "44.811871605508614"
        private var longitude = "20.387621036232584"
    
}

extension TripApiNetwork: TripApiNetworkProtocol {
    func fetchData(rate: String, kind: String, completion: @escaping (Result<[Attraction], MoyaError>) -> Void) {
        
        let target = TripApiTargetType.fetchData(rate: rate, kind: kind, radius: radius, longitude: longitude, latitude: latitude, limit: limit, apiKey: apiKey)
        
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
}
    


//class NetworkService {
    
////    private let locationService = LocationService()
//    private let baseUrl = "https://api.opentripmap.com/0.1/en/places/"
//    private var firstPartUrl = ""
//    private var secondPartUrl = ""
//    private var finalUrl = ""
//    private let apiKey = "5ae2e3f221c38a28845f05b6811ec1c8612b2b7b55d46425957df5a4"
//    private var radius = "100000"
//    private var limit = "1000"
//    private var latitude = "44.811871605508614"
//    private var longitude = "20.387621036232584"
//}
    
//    func downloadImage(imageURL: String, completion: @escaping (Result<Data, Error>) -> Void) {
//        guard let url = URL(string: imageURL) else { return }
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                completion(.failure(error))
//                print("DataTask error \(error.localizedDescription)")
//                return
//            }
//            guard let response = response as? HTTPURLResponse else {
//                print("Empty Response")
//                return
//            }
//            print("Response status code: \(response.statusCode)")
//
//            guard let data = data else { return }
//
//            do {
//                let image = data
//                completion(.success(image))
//            }
//        }
//        task.resume()
//    }
//
//    func fetchDetailsData(xid: String, completion: @escaping (Result<AttractionDetail, Error>) -> Void) {
//
//        finalUrl = baseUrl + "xid/" + xid + "?apikey=" + apiKey
//
//        guard let url = URL(string: finalUrl) else {return}
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            if let error = error {
//                completion(.failure(error))
//                print("DataTask error \(error.localizedDescription)")
//                return
//            }
//            guard let response = response as? HTTPURLResponse else {
//                print("Empty Response")
//                return
//            }
//            print("Response status code: \(response.statusCode)")
//
//            guard let data = data else { return }
//
//            do {
//                let attraction = try JSONDecoder().decode(AttractionDetail.self, from: data)
//                completion(.success(attraction))
//            }
//            catch {
//                completion(.failure(error))
//            }
//        }
//        task.resume()
//    }

    
    
//    func fetchData(rate: String, kinds: String, completion: @escaping (Result<[Attraction], Error>) -> Void) {
//
////        locationService.getUserLocation { lat, lon in
////            latitude = lat
////            longitude = lon
////        }
//
//        firstPartUrl = "radius?radius=" + radius + "&lon=" + longitude + "&lat=" + latitude + "&kinds=" + kinds + "&rate=" + rate
//
//        secondPartUrl = "&format=json" + "&limit=" + limit + "&apikey=" + apiKey
//
//        finalUrl = baseUrl + firstPartUrl + secondPartUrl
//
//        guard let url = URL(string: finalUrl) else {return}
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            if let error = error {
//                completion(.failure(error))
//                print("DataTask error \(error.localizedDescription)")
//                return
//            }
//            guard let response = response as? HTTPURLResponse else {
//                print("Empty Response")
//                return
//            }
//            print("Response status code: \(response.statusCode)")
//
//            guard let data = data else { return }
//
//            do {
//                let attraction = try JSONDecoder().decode([Attraction].self, from: data)
//                completion(.success(attraction))
//            }
//            catch {
//                completion(.failure(error))
//            }
//        }
//        task.resume()
//    }

