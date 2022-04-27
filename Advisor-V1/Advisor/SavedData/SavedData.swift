//
//  SavedData.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 20.10.2021.
//

import Foundation

class SavedData {
    static let shared = SavedData()
    
    struct SavedItem: Codable {
        var itemTitle: String
        var itemXid: String
    }
    
    var listITems: [SavedItem] {
        get {
            if let data = UserDefaults.standard.value(forKey: "items") as? Data {
                guard let decodedData = try? PropertyListDecoder().decode([SavedItem].self, from: data) else {
                    return []
                }
                return decodedData
            }
            else {
                return []
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.setValue(data, forKey: "items")
            }
        }
    }
    
    func saveItem(title: String, xid: String) {
        let item = SavedItem(itemTitle: title, itemXid: xid)
        listITems.insert(item, at: 0)
    }
    
}
