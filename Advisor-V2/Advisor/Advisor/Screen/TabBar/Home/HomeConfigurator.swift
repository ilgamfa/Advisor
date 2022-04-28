//
//  HomeConfigurator.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation
import UIKit

protocol HomeConfiguratorProtocol {
    func configure(view: HomeView)
}

class HomeConfigurator: HomeConfiguratorProtocol {
    func configure(view: HomeView) {
        let presenter = HomePresenter(view: view)
        let interactor = HomeInteractor(presenter: presenter)
        let router = HomeRouter(view: view)
        let entity = HomeEntity()
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.entity = entity
    }
}
