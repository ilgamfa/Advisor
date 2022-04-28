//
//  MapPresenter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol MapPresenterProtocol: AnyObject {
    
}

class MapPresenter: MapPresenterProtocol {
    weak var view: MapViewProtocol?
    var interactor: MapInteractorProtocol?
    var router: MapRouterProtocol?
    
    init(view: MapViewProtocol) {
        self.view = view
    }
}
