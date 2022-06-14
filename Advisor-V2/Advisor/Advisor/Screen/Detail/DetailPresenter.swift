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
}

class DetailPresenter {
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    
    init(view: DetailViewProtocol) {
        self.view = view
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func presentFlow(xid: String) {
        interactor?.fetchDetailData(xid: xid, completion: { result in
            switch result {
            case .success(let detail):
                if let imageSource = detail.preview?.source {
                    self.downloadImage(source: imageSource) { result in
                        switch result {
                        case .success(let image):
                            self.view?.configureDetailFlow(model: AttractionDetailModel(objectImage: image, attractionDetail: detail))
                        case .failure(let error):
                            self.view?.configureDetailFlow(model: AttractionDetailModel(objectImage: nil, attractionDetail: detail))
                            debugPrint(error)
                        }
                    }
                } else {
                    self.view?.configureDetailFlow(model: AttractionDetailModel(objectImage: nil, attractionDetail: detail))
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
}
