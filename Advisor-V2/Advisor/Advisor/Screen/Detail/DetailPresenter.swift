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
                print(detail)
                let name = detail.name ?? "No name yet"
                let kinds = detail.kinds ?? ""
                let description = detail.wikipedia_extracts?.text ?? kinds
                if let imageSource = detail.preview?.source {
                    self.downloadImage(source: imageSource) { result in
                        switch result {
                        case .success(let image):
                            self.view?.configureDetailFlow(image: image, title: name, description: description)
                        case .failure(let error):
                            self.view?.configureDetailFlow(image: nil, title: name, description: description)
                            debugPrint(error)
                        }
                    }
                } else {
                    self.view?.configureDetailFlow(image: nil, title: name, description: description)
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
}
