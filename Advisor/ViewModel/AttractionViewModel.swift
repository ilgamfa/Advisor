//
//  AttractionViewModel.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 30.09.2021.
//

import Foundation

class AttractionViewModel {
    private var networkManager = NetworkManager()
    private var attractionData = [Attraction]()
    
    func fetchData(completion: @escaping () -> ()) {
        networkManager.fetchData { result in
            switch result {
            case .success(let attractions):
                self.attractionData = attractions
                completion()
            case .failure(let error):
                print("Error procession json data: \(error)")
            }
        }
    }
    
    
    
    func numbersOfRowsInSection(section: Int) -> Int {
        if attractionData.count != 0 {
            return attractionData.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Attraction {
        return attractionData[indexPath.row]
    }
    
}
