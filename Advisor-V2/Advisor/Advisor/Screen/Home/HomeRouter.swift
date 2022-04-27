//
//  HomeRouter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol HomeRouterProtocol: AnyObject {
}

class HomeRouter: HomeRouterProtocol {
    
    weak var view: HomeViewProtocol?
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
}
