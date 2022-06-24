//
//  SettingsInteractor.swift
//  Advisor_V2
//
//  Created by Ilgam Akhmatdinov on 19.06.2022.
//

import Foundation
import Moya
import Alamofire

protocol SettingsInteractorProtocol {

}

class SettingsInteractor {
    weak var presenter: SettingsPresenterProtocol?
    var tripApi: TripApiNetworkProtocol?
    
    init(presenter: SettingsPresenterProtocol, tripApi: TripApiNetworkProtocol) {
        self.presenter = presenter
        self.tripApi = tripApi
    }
}

extension SettingsInteractor: SettingsInteractorProtocol {
}
