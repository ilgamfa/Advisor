//
//  HomeRouter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol HomeRouterProtocol: AnyObject {
    func routeToFeedView(title: String, index: Int)
}

class HomeRouter {
    
    weak var view: HomeView?
    
    init(view: HomeView) {
        self.view = view
    }
}

extension HomeRouter: HomeRouterProtocol {
    func routeToFeedView(title: String, index: Int) {
        let feedView = FeedView(nibName: FeedView.identifier, bundle: nil)
        feedView.title = title
        feedView.indexFlow = index
        view?.navigationController?.pushViewController(feedView, animated: true)
    }
}
