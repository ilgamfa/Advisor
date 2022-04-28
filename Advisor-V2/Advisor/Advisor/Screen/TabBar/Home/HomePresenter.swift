//
//  HomePresenter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func getCategoryModels() -> [CategoryModel]
    func presentFeedView()
}

class HomePresenter {
    
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    var entity: HomeEntityProtocol?
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func getCategoryModels() -> [CategoryModel] {
        guard let models = entity?.getCategoryModels() else { return []}
        return models
    }
    
    func presentFeedView() {
        router?.routeToFeedView()
    }
}
