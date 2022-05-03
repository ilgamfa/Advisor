//
//  FeedRouter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation

protocol FeedRouterProtocol: AnyObject {
    func routeToDetailView(xid: String)
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
}
