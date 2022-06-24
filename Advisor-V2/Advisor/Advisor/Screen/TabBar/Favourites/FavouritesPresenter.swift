//
//  FavouritesPresenter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol FavouritesPresenterProtocol: AnyObject {
    func dismissScreen()
    func presentDetailView(xid: String)
}

class FavouritesPresenter: FavouritesPresenterProtocol {
    
    weak var view: FavouritesViewProtocol?
    var interactor: FavouritesInteractorProtocol?
    var router: FavouritesRouterProtocol?
    
    init(view: FavouritesViewProtocol) {
        self.view = view
    }
    
    func dismissScreen() {
        router?.dismissScreen()
    }
    
    func presentDetailView(xid: String) {
        router?.routeToDetailView(xid: xid)
    }
}
