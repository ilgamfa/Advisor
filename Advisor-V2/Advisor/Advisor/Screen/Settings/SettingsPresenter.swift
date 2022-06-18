//
//  SettingsPresenter.swift
//  Advisor_V2
//
//  Created by Ilgam Akhmatdinov on 19.06.2022.
//

import Foundation
import UIKit
import Moya
import Alamofire

protocol SettingsPresenterProtocol: AnyObject {
 
}

class SettingsPresenter {
    weak var view: SettingsViewProtocol?
    var interactor: SettingsInteractorProtocol?
    var router: SettingsRouterProtocol?
    
    init(view: SettingsViewProtocol) {
        self.view = view
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
}
