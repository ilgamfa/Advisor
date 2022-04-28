//
//  HomeRouter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol HomeRouterProtocol: AnyObject {
    func routeToFeedView()
}

class HomeRouter {
    
    weak var view: HomeView?
    
    init(view: HomeView) {
        self.view = view
    }
}

extension HomeRouter: HomeRouterProtocol {
    func routeToFeedView() {
        let feedView = FeedView(nibName: FeedView.identifier, bundle: nil)
        view?.navigationController?.pushViewController(feedView, animated: true)
    }
}
