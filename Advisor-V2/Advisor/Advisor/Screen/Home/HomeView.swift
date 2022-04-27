//
//  HomeView.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    
}

class HomeView: UIViewController {

    var presenter: HomePresenterProtocol?
    var configurator = HomeConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(view: self)
        
        view.backgroundColor = .blue
    }
}

extension HomeView: HomeViewProtocol {
    
}
