//
//  MapInteractor.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import UIKit

protocol MapInteractorProtocol: AnyObject {
    
}

class MapInteractor: MapInteractorProtocol {
    weak var presenter: MapPresenterProtocol?
    
    init(presenter: MapPresenterProtocol) {
        self.presenter = presenter
    }
}
