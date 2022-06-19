//
//  SettingsConfigurator.swift
//  Advisor_V2
//
//  Created by Ilgam Akhmatdinov on 19.06.2022.
//

import Foundation

protocol SettingsConfiguratorProtocol {
    func configure(view: SettingsView)
}

class SettingsConfigurator: SettingsConfiguratorProtocol {
    func configure(view: SettingsView) {
        let presenter = SettingsPresenter(view: view)
        let tripApi = TripApiNetwork()
        let interactor = SettingsInteractor(presenter: presenter, tripApi: tripApi)
        let router = SettingsRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        interactor.tripApi = tripApi
    }
}
