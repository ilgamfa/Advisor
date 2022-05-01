//
//  FeedPresenter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation

protocol FeedPresenterProtocol: AnyObject {
    func presentFlow(indexPath: Int) -> Flow
    func getAttractions() -> [Attraction]
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
            interactor?.fetchTableData(rate: flow.rate, kind: flow.collectionItemName, completion: { result in
                switch result {
                case .success(let attractions):
                    self.entity?.setAttractions(attractions: attractions)
                    self.view?.reloadTableView()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            return flow
        }
        fatalError()
    }
    
    func getAttractions() -> [Attraction] {
        guard let attractions = entity?.getAttractions() else { return []}
        return attractions
    }
}
