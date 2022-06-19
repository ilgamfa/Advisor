//
//  FavouritesRouter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol FavouritesRouterProtocol: AnyObject {
    func dismissScreen()
    func routeToDetailView(xid: String)
}

class FavouritesRouter: FavouritesRouterProtocol {
    weak var view: FavouritesView?
    
    init(view: FavouritesView) {
        self.view = view
    }
    
    func dismissScreen() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func routeToDetailView(xid: String) {
        let detail = DetailView(nibName: DetailView.identifier, bundle: nil)
        detail.xid = xid
        view?.navigationController?.pushViewController(detail, animated: true)
    }
}
