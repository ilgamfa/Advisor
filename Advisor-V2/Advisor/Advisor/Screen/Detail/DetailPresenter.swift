//
//  DetailPresenter.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 02.05.2022.
//

import Foundation
import UIKit
import Moya
import Alamofire

protocol DetailPresenterProtocol: AnyObject {
    func presentFlow(xid: String)
    func presentFavourites()
    func presentMap(model: AttractionDetail)
    func saveDidTap(xid: String, name: String?)
}

class DetailPresenter {
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    var storeService = StoreService()
    
    init(view: DetailViewProtocol) {
        self.view = view
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func presentFlow(xid: String) {
        view?.showIndicator(show: true)
        let isExist = storeService.checkExist(xid: xid)
        interactor?.fetchDetailData(xid: xid, completion: { result in
            switch result {
            case .success(let detail):
                if let imageSource = detail.preview?.source {
                    self.downloadImage(source: imageSource) { result in
                        switch result {
                        case .success(let image):
                            self.view?.configureDetailFlow(model: AttractionDetailModel(objectImage: image, attractionDetail: detail), isExist: isExist)
                        case .failure(let error):
                            self.view?.configureDetailFlow(model: AttractionDetailModel(objectImage: nil, attractionDetail: detail), isExist: isExist)
                            debugPrint(error)
                        }
                        self.view?.showIndicator(show: false)
                    }
                } else {
                    self.view?.configureDetailFlow(model: AttractionDetailModel(objectImage: nil, attractionDetail: detail), isExist: isExist)
                    self.view?.showIndicator(show: false)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    private func downloadImage(source: String, completion: @escaping (Result<UIImage, AFError>) -> Void) {
        interactor?.downloadImage(imageSource: source, completion: { result in
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func presentFavourites() {
        router?.routeToFavourites()
    }
    
    func presentMap(model: AttractionDetail) {
        router?.routeToMap(model: model)
    }
    
    func saveDidTap(xid: String, name: String?) {
        DispatchQueue.main.async {
            if !self.storeService.checkExist(xid: xid) {
                self.view?.setButtonState(isExist: true)
                self.storeService.writeAttraction(xid: xid, name: name)
            } else {
                self.view?.setButtonState(isExist: false)
                self.storeService.deleteAttraction(xid: xid)
            }
        }
    }
}
