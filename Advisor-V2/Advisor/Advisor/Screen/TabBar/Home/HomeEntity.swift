//
//  HomeEntity.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation
import UIKit

struct CategoryModel {
    let categoryImageName: String
    let categoryLabel: String
}

protocol HomeEntityProtocol {
    func getCategoryModels() -> [CategoryModel]
}

class HomeEntity: HomeEntityProtocol {
    let categoryModels: [CategoryModel] = [
        CategoryModel(categoryImageName: "interestingPlaces", categoryLabel: "Interesting places"),
        CategoryModel(categoryImageName: "touristFacilities", categoryLabel: "Tourist facilities"),
        CategoryModel(categoryImageName: "amusements", categoryLabel: "Amusements"),
        CategoryModel(categoryImageName: "accommodations", categoryLabel: "Accommodations"),
        CategoryModel(categoryImageName: "sport", categoryLabel: "Sport"),
        CategoryModel(categoryImageName: "adult", categoryLabel: "Adult"),
    ]
    
    func getCategoryModels() -> [CategoryModel] {
        return categoryModels
    }
}


