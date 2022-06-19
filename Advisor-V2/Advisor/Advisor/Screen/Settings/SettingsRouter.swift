//
//  SettingsRouter.swift
//  Advisor_V2
//
//  Created by Ilgam Akhmatdinov on 19.06.2022.
//

import Foundation

protocol SettingsRouterProtocol {

}

class SettingsRouter: SettingsRouterProtocol {
    weak var view: SettingsView?
    
    init(view: SettingsView) {
        self.view = view
    }
}
