//
//  CategoryCell.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet private weak var categoryImageVIew: UIImageView!
    
    @IBOutlet private weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout() {
        self.layer.cornerRadius = 8
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 3)
        self.layer.shadowRadius = 3
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
    }
    
    func configureCell(imageName: String, label: String) {
        categoryImageVIew.image = UIImage(named: imageName)
        categoryLabel.text = label
    }
    
    func getTitle() -> String {
        guard let title = categoryLabel.text else { return "" }
        return title
    }

}
