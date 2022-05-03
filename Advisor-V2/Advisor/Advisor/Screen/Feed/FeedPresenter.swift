//
//  FeedPresenter.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation

protocol FeedPresenterProtocol: AnyObject {
    func presentFlow(indexPath: Int) -> Flow
    func presentTableData(rate: String, kind: String)
    func getAttractions() -> [Attraction]
    func getHeader() -> String
    func setHeader(header: String)
    func presentDetailView(xid: String)
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
            view?.showSpinner(show: true)
            presentTableData(rate: flow.rate, kind: flow.collectionItemName)
            return flow
        }
        fatalError()
    }
    
    func presentTableData(rate: String, kind: String) {
        view?.showSpinner(show: true)
        interactor?.fetchTableData(rate: rate, kind: kind, completion: { result in
            switch result {
            case .success(let attractions):
                self.entity?.setAttractions(attractions: attractions)
                self.view?.showImageNoData(show: attractions.isEmpty)
                self.view?.reloadTableView()
                self.view?.showSpinner(show: false)
            case .failure(let error):
                self.view?.showAlertError(message: error.localizedDescription)
            }
        })
    }
    
    func getAttractions() -> [Attraction] {
        guard let attractions = entity?.getAttractions() else { return []}
        
        return attractions
    }
    
    func getHeader() -> String {
        guard let header = entity?.getHeader() else { return "" }
        return header
    }
    
    func setHeader(header: String) {
        entity?.setHeader(header: header)
    }
    
    func presentDetailView(xid: String) {
        router?.routeToDetailView(xid: xid)
    }
    
}
