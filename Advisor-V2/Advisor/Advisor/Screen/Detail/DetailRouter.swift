//
//  DetailRouter.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 02.05.2022.
//

import Foundation

protocol DetailRouterProtocol {
    
}

class DetailRouter: DetailRouterProtocol {
    weak var view: DetailView?
    
    init(view: DetailView) {
        self.view = view
    }
}
