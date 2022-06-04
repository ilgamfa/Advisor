//
//  MapRouter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol MapRouterProtocol: AnyObject {
    func routeToDetailView(xid: String)
}

class MapRouter: MapRouterProtocol {
    
    weak var view: MapView?
    
    init(view: MapView) {
        self.view = view
    }
    
    func routeToDetailView(xid: String) {
        let detail = DetailView(nibName: DetailView.identifier, bundle: nil)
        detail.xid = xid
        view?.navigationController?.pushViewController(detail, animated: true)
    }
}
