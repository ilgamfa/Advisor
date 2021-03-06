//
//  FeedConfigurator.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation
import UIKit

protocol FeedConfiguratorProtocol {
    func configure(view: FeedView)
}

class FeedConfigurator: FeedConfiguratorProtocol {
    func configure(view: FeedView) {
        let presenter = FeedPresenter(view: view)
        let tripApi = TripApiNetwork()
        let locationService = LocationService()
        let interactor = FeedInteractor(presenter: presenter, tripApi: tripApi, locationService: locationService)
        let router = FeedRouter(view: view)
        let entity = FeedEntity()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.entity = entity
        interactor.tripApi = tripApi
        interactor.locationService = locationService
    }
}
