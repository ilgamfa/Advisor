//
//  CollectionViewHeader.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 01.05.2022.
//

import Foundation
import UIKit

class CollectionViewHeader: UICollectionReusableView {
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(title)
     
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor,
                                           constant: 16),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
