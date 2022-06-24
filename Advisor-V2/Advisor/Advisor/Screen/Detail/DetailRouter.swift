//
//  DetailRouter.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 02.05.2022.
//

import Foundation

protocol DetailRouterProtocol {
    func routeToFavourites()
    func routeToMap(model: AttractionDetail)
}

class DetailRouter: DetailRouterProtocol {
    weak var view: DetailView?
    
    init(view: DetailView) {
        self.view = view
    }
    
    func routeToFavourites() {
        let favourites = FavouritesView(nibName: FavouritesView.identifier, bundle: nil)
        view?.navigationController?.pushViewController(favourites, animated: true)
    }
    
    func routeToMap(model: AttractionDetail) {
        let map = MapView(nibName: MapView.identifier, bundle: nil)
        map.mapFlow = .oneObject
        map.model = model
        view?.navigationController?.pushViewController(map, animated: true)
    }
}
