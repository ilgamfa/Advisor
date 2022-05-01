//
//  FeedPresenter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation

protocol FeedPresenterProtocol: AnyObject {
    func presentFlow(indexPath: Int) -> Flow
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
    func presentFlow(indexPath: Int) -> Flow {
        if let flow = entity?.getFlow(indexPath: indexPath) {
            return flow
        }
        fatalError()
    }
}
