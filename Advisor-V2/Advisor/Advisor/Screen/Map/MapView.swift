//
//  MapView.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import UIKit

protocol MapViewProtocol: AnyObject {
    
}

class MapView: UIViewController {
    
    var presenter: MapPresenterProtocol?
    var configurator = MapConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(view: self)
        
        view.backgroundColor = .cyan
    }
}

extension MapView: MapViewProtocol {
    
}
