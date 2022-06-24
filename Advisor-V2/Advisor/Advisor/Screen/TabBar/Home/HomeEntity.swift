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
        CategoryModel(categoryImageName: "interestingPlaces", categoryLabel: "Что-то интересное"),
        CategoryModel(categoryImageName: "touristFacilities", categoryLabel: "Для туристов"),
        CategoryModel(categoryImageName: "amusements", categoryLabel: "Развлечения"),
        CategoryModel(categoryImageName: "accommodations", categoryLabel: "Жилье"),
        CategoryModel(categoryImageName: "sport", categoryLabel: "Спорт"),
        CategoryModel(categoryImageName: "adult", categoryLabel: "Для взрослых"),
    ]
    
    func getCategoryModels() -> [CategoryModel] {
        return categoryModels
    }
}


