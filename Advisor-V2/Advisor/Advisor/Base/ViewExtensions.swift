//
//  ViewExtensions.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    public class var identifier: String {
        return "\(self.self)"
    }
}
extension UICollectionViewCell {
    public class var identifier: String {
        return "\(self.self)"
    }
}

