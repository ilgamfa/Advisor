//
//  FeedRouter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation

protocol FeedRouterProtocol: AnyObject {
    
}

class FeedRouter {
    
    weak var view: FeedView?
    
    init(view: FeedView) {
        self.view = view
    }
}

extension FeedRouter: FeedRouterProtocol {
    
}
