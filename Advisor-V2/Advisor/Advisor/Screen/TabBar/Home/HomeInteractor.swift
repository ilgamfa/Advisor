//
//  HomeInteractor.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    
}

class HomeInteractor: HomeInteractorProtocol {
    
    weak var presenter: HomePresenterProtocol?
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }
}
