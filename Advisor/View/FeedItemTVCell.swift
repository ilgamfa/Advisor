//
//  CollectionItemTVCell.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 07.10.2021.
//

import UIKit

class FeedItemTVCell: UITableViewCell {

    @IBOutlet weak var collectionItemImage: UIImageView!
    @IBOutlet weak var collectionItemLabel: UILabel!
    
    func setCellWithValuesOf(_ attraction: Attraction) {
        updateUI(itemLabel: attraction.name)
    }
    
    private func updateUI(itemLabel: String?) {
        self.collectionItemLabel.text = itemLabel
    }
    
    private func getImageDataFrom(url: URL) {
        // do response to get image
    }
    
    
}
