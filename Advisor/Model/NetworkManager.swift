//
//  request.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 30.09.2021.
//

import Foundation

class NetworkManager {
   
    
    func fetchData(completion: (Result<Attraction, Error>) -> Void) {
        
        let urlString = "https://api.opentripmap.com/0.1/en/places/radius?radius=1000&lon=49.1233&lat=55.7879&format=json&apikey=5ae2e3f221c38a28845f05b6811ec1c8612b2b7b55d46425957df5a4"
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("DataTask error \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            do {
                let attraction = try JSONDecoder().decode([Attraction].self, from: data)
               
           
            }
            catch {
                print(error.localizedDescription)
            }
            
            

        }
        task.resume()
     
    }
  
}
