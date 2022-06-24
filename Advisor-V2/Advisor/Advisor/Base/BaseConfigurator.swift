//
//  BaseConfigurator.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation
import UIKit

protocol BaseConfiguratorProtocol {
    func configure(view: BaseViewProtocol,
                   interactor: BaseInteractorProtocol,
                   presenter: BasePresenterProtocol,
                   router: BaseRouterProtocol)
}

class BaseConfigurator: BaseConfiguratorProtocol {
    func configure(view: BaseViewProtocol, interactor: BaseInteractorProtocol, presenter: BasePresenterProtocol, router: BaseRouterProtocol) {
        fatalError("Must override configure of BaseConfigurator")
    }
}
