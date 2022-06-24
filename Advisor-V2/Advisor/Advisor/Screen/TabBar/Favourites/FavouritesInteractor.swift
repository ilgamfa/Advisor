//
//  FavouritesInteractor.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation


protocol FavouritesInteractorProtocol: AnyObject {
}

class FavouritesInteractor: FavouritesInteractorProtocol {
    weak var presenter: FavouritesPresenterProtocol?
    
    init(presenter: FavouritesPresenterProtocol) {
        self.presenter = presenter
    }
    
}

