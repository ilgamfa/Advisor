//
//  request.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 30.09.2021.
//

import Foundation
import UIKit

class NetworkService {
    
    private let locationService = LocationService()
//                        "https://api.opentripmap.com/0.1/ru/places/xid/W572416599?apikey=5ae2e3f221c38a28845f05b6811ec1c8612b2b7b55d46425957df5a4"
    private let baseUrl = "https://api.opentripmap.com/0.1/en/places/"
    private var firstPartUrl = ""
    private var secondPartUrl = ""
    private var finalUrl = ""
    private let apiKey = "5ae2e3f221c38a28845f05b6811ec1c8612b2b7b55d46425957df5a4"
    private var languageType = "en"
    private var radius = "100000"
    private var limit = "1000"
    private var latitude = ""
    private var longitude = ""
    
    func downloadImage(imageURL: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: imageURL) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask error \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else { return }
            
            do {
                let image = data
                completion(.success(image))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchDetailsData(xid: String, completion: @escaping (Result<AttractionDetail, Error>) -> Void) {
        
        finalUrl = baseUrl + "xid/" + xid + "?apikey=" + apiKey
        
        guard let url = URL(string: finalUrl) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask error \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else { return }
            
            do {
                let attraction = try JSONDecoder().decode(AttractionDetail.self, from: data)
                completion(.success(attraction))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    
    
    func fetchData(rate: String, kinds: String, completion: @escaping (Result<[Attraction], Error>) -> Void) {
        
        locationService.getUserLocation { lat, lon in
            latitude = lat
            longitude = lon
        }

        firstPartUrl = "radius?radius=" + radius + "&lon=" + longitude + "&lat=" + latitude + "&kinds=" + kinds + "&rate=" + rate
        
        secondPartUrl = "&format=json" + "&limit=" + limit + "&apikey=" + apiKey
        
        finalUrl = baseUrl + firstPartUrl + secondPartUrl
        
        guard let url = URL(string: finalUrl) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask error \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else { return }
            
            do {
                let attraction = try JSONDecoder().decode([Attraction].self, from: data)
                completion(.success(attraction))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
