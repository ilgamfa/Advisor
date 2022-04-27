//
//  MapRouter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol MapRouterProtocol: AnyObject {
    
}

class MapRouter: MapRouterProtocol {
    
    weak var view: MapViewProtocol?
    
    init(view: MapViewProtocol) {
        self.view = view
    }
}
