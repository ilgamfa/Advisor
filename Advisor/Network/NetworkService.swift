//
//  request.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 30.09.2021.
//

import Foundation

class NetworkService {
    
    private let locationService = LocationService()
    
    let baseUrl = "https://api.opentripmap.com/0.1/ru/places/"
    var firstPartUrl = ""
    var secondPartUrl = ""
    var finalUrl = ""
    let apiKey = "5ae2e3f221c38a28845f05b6811ec1c8612b2b7b55d46425957df5a4"
    var languageType = "en"
    var radius = "1050000"
    var limit = "10000"
    var latitude = ""
    var longitude = ""
    
    func fetchData(kinds: String, completion: @escaping (Result<[Attraction], Error>) -> Void) {
        
                
        locationService.getUserLocation { lat, lon in
            latitude = lat
            longitude = lon
        }

        firstPartUrl = "radius?radius=" + radius + "&lon=" + longitude + "&lat=" + latitude + "&kinds=" + kinds
        
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
    
//    func fetchDetails(completion: @escaping (Result<[Attraction], Error>) -> Void) {
//
//        locationService.getUserLocation { lat, lon in
//            latitude = lat
//            longitude = lon
//        }
//
//        let finalUrl = baseUrl + languageType + "/places/radius?radius=" + radius + "&lon=" + longitude + "&lat=" + latitude + "&format=json" + "&apikey=" + apiKey
//
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
  
}
