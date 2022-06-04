//
//  MapConfigurator.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol MapConfiguratorProtocol {
    func configure(view: MapView)
}

class MapConfigurator: MapConfiguratorProtocol {
    func configure(view: MapView) {
        let presenter = MapPresenter(view: view)
        let tripApi = TripApiNetwork()
        let locationService = LocationService()
        let interactor = MapInteractor(presenter: presenter, tripApi: tripApi, locationService: locationService)
        let router = MapRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        interactor.tripApi = tripApi
        interactor.locationService = locationService
    }
}
