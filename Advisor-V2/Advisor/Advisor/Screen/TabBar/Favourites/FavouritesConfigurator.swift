//
//  FavouritesConfigurator.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol FavouritesConfiguratorProtocol {
    func configure(view: FavouritesView)
}

class FavouritesConfigurator: FavouritesConfiguratorProtocol {
    func configure(view: FavouritesView) {
        let presenter = FavouritesPresenter(view: view)
        let interactor = FavouritesInteractor(presenter: presenter)
        let router = FavouritesRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
