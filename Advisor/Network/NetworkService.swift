//
//  request.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 30.09.2021.
//

import Foundation
import MapKit

class NetworkService {
    
    private let locationService = LocationService()
    var array =  [Annotation]()
    
    let baseUrl = "https://api.opentripmap.com/0.1/"
    let apiKey = "5ae2e3f221c38a28845f05b6811ec1c8612b2b7b55d46425957df5a4"
    var languageType = "en"
    var radius = "25000"
    
    var latitude = ""
    var longitude = ""
    
    
    func fetchGeoJsonData(completion: @escaping (Result<[Annotation], Error>) -> Void) {

        let finalUrl = baseUrl + languageType + "/places/radius?radius=" + radius + "&lon=" + longitude + "&lat=" + latitude + "&format=geojson" + "&apikey=" + apiKey
        
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
                let annotation = try MKGeoJSONDecoder().decode(data).compactMap { $0 as? Annotation }

                completion(.success(annotation))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    
    
    
    func fetchData(completion: @escaping (Result<[Attraction], Error>) -> Void) {
        
        locationService.getUserLocation { lat, lon in
            latitude = lat
            longitude = lon
        }
        
        let finalUrl = baseUrl + languageType + "/places/radius?radius=" + radius + "&lon=" + longitude + "&lat=" + latitude + "&format=json" + "&apikey=" + apiKey
        
        
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
