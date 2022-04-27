//
//  FavouritesRouter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol FavouritesRouterProtocol: AnyObject {
    
}

class FavouritesRouter: FavouritesRouterProtocol {
    weak var view: FavouritesViewProtocol?
    
    init(view: FavouritesViewProtocol) {
        self.view = view
    }
}
