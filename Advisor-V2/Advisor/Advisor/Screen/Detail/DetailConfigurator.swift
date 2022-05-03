//
//  DetailConfigurator.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 02.05.2022.
//

import Foundation

protocol DetailConfiguratorProtocol {
    func configure(view: DetailView)
}

class DetailConfigurator: DetailConfiguratorProtocol {
    func configure(view: DetailView) {
        let presenter = DetailPresenter(view: view)
        let tripApi = TripApiNetwork()
        let interactor = DetailInteractor(presenter: presenter, tripApi: tripApi)
        let router = DetailRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        interactor.tripApi = tripApi
    }
}
