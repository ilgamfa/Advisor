//
//  HomeTableViewCell.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 30.09.2021.
//

import Foundation
import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    // MARK: Outlet

    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var collectionLabel: UILabel!
    
    
//    func setCellWithValues(_ attraction: Attraction) {
//        updateUI(nameTitle: attraction.name, latitudeTitle: attraction.point.lat, longitudeTitle: attraction.point.lon)
//    }
//
//    private func updateUI(nameTitle: String?, latitudeTitle: Double?, longitudeTitle: Double?) {
//        self.longitudeLabel.text! += " " + String(format: "%f", longitudeTitle!)
//        self.latitudeLabel.text! += " " + String(format: "%f", latitudeTitle!)
//        self.nameLabel.text = nameTitle
//    }
 
}
