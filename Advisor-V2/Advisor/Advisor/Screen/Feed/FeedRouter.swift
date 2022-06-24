//
//  FeedRouter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation

protocol FeedRouterProtocol: AnyObject {
    func routeToDetailView(xid: String)
    func routeToMapView(rate: String, kind: String)
    func routeToFavourites()
}

class FeedRouter {
    
    weak var view: FeedView?
    
    init(view: FeedView) {
        self.view = view
    }
}

extension FeedRouter: FeedRouterProtocol {
    func routeToDetailView(xid: String) {
        let detail = DetailView(nibName: DetailView.identifier, bundle: nil)
        detail.xid = xid
        view?.navigationController?.pushViewController(detail, animated: true)
    }
    
    func routeToMapView(rate: String, kind: String) {
        let mapView = MapView(nibName: MapView.identifier, bundle: nil)
        mapView.rate = rate
        mapView.kind = kind
        mapView.mapFlow = .category
        view?.navigationController?.pushViewController(mapView, animated: true)
    }
    
    func routeToFavourites() {
        let favourites = FavouritesView(nibName: FavouritesView.identifier, bundle: nil)
        view?.navigationController?.pushViewController(favourites, animated: true)
    }
}
