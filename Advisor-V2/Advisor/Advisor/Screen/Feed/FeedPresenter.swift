//
//  FeedPresenter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation

protocol FeedPresenterProtocol: AnyObject {
    func presentFlow(indexPath: Int)
}

class FeedPresenter {
    
    weak var view: FeedViewProtocol?
    var interactor: FeedInteractorProtocol?
    var router: FeedRouterProtocol?
    var entity: FeedEntityProtocol?
    
    init(view: FeedViewProtocol) {
        self.view = view
    }
}

extension FeedPresenter: FeedPresenterProtocol {
    func presentFlow(indexPath: Int) {
        entity?.getFlow(indexPath: indexPath)
    }
}
