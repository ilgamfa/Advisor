//
//  FafouritesView.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import UIKit

protocol FavouritesViewProtocol: AnyObject {
    
}

class FavouritesView: UIViewController {

    var presenter: FavouritesPresenterProtocol?
    var configurator = FavouritesConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(view: self)
        view.backgroundColor = .green
    }
}

extension FavouritesView: FavouritesViewProtocol {
    
}
