//
//  FeedInteractor.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation

protocol FeedInteractorProtocol: AnyObject {
    
}

class FeedInteractor: FeedInteractorProtocol {
    
    weak var presenter: FeedPresenterProtocol?
    
    init(presenter: FeedPresenterProtocol) {
        self.presenter = presenter
    }
}

