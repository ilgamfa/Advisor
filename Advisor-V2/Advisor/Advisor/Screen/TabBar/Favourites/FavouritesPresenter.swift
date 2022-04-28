//
//  FavouritesPresenter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol FavouritesPresenterProtocol: AnyObject {
    
}

class FavouritesPresenter: FavouritesPresenterProtocol {
    
    weak var view: FavouritesViewProtocol?
    var interactor: FavouritesInteractorProtocol?
    var router: FavouritesRouterProtocol?
    
    init(view: FavouritesViewProtocol) {
        self.view = view
    }
}