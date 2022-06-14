//
//  FavouritesRouter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol FavouritesRouterProtocol: AnyObject {
    func dismissScreen()
}

class FavouritesRouter: FavouritesRouterProtocol {
    weak var view: FavouritesView?
    
    init(view: FavouritesView) {
        self.view = view
    }
    
    func dismissScreen() {
        view?.navigationController?.popViewController(animated: true)
    }
}
