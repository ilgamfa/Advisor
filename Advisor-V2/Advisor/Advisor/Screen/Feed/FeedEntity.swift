//
//  FeedEntity.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation
import UIKit

struct Flow {
    let rate: String
    let collectionItemName: String
    let collectionViewCellNames: [String]
    let collectionViewCellImages: [String]
    let collectionViewCellRequestSubcatNames: [String]
    let collectionViewCellRequestSubcatRates: [String]
}

struct Attraction: Decodable {
    var xid: String
    var name: String?
    var point: Point
    var kinds: String
}

struct Point: Decodable {
    var lat: Double
    var lon: Double
}

protocol FeedEntityProtocol {
    func getFlow(indexPath: Int) -> Flow
    func setAttractions(attractions: [Attraction])
    func getAttractions() -> [Attraction]
    func getHeader() -> String
    func setHeader(header: String)
}

class FeedEntity: FeedEntityProtocol {
    
    var tableViewHeader = "Рядом со мной"
    var attractions: [Attraction] = []
    
    func getAttractions() -> [Attraction] {
        return self.attractions
    }
    
    func setAttractions(attractions: [Attraction]) {
        self.attractions = attractions
    }
    
    func setHeader(header: String) {
        self.tableViewHeader = header
    }
    
    func getHeader() -> String {
        return tableViewHeader
    }
    
    func getFlow(indexPath: Int) -> Flow {
        switch indexPath {
        case 0:
            return Flow(rate: "1h",
                        collectionItemName: "interesting_places",
                        collectionViewCellNames: [ "Все",
                                                   "Архитектура",
                                                   "Культура",
                                                   "Историческое",
                                                   "Религия",
                                                   "Индустрия",
                                                   "Природа",
                                                   "Другие"],
                        collectionViewCellImages: [ "all",
                                                    "architecture",
                                                    "culture",
                                                    "historical",
                                                    "religion",
                                                    "industrial",
                                                    "nature",
                                                    "other"],
                        collectionViewCellRequestSubcatNames: [ "interesting_places",
                                                                "architecture",
                                                                "cultural",
                                                                "historic",
                                                                "religion",
                                                                "industrial_facilities",
                                                                "natural",
                                                                "other"],
                        collectionViewCellRequestSubcatRates: [ "1h",
                                                                "1h",
                                                                "3",
                                                                "3",
                                                                "3",
                                                                "1",
                                                                "3",
                                                                "1"])

        case 1:
            return Flow(rate: "1",
                        collectionItemName: "tourist_facilities",
                        collectionViewCellNames: [ "Все",
                                                   "Банки",
                                                   "Еда",
                                                   "Магазины",
                                                   "Транспорт"],
                        collectionViewCellImages: [ "all",
                                                    "banks",
                                                    "foods",
                                                    "shops",
                                                    "transport"],
                        collectionViewCellRequestSubcatNames: ["tourist_facilities",
                                                               "banks",
                                                               "foods",
                                                               "shops",
                                                               "transport"],
                        collectionViewCellRequestSubcatRates: [     "1",
                                                                    "1",
                                                                    "1",
                                                                    "1",
                                                                    "1"])
            
        case 2:
            return Flow(rate: "1",
                        collectionItemName: "amusements",
                        collectionViewCellNames: [ "Все",
                                                   "Парки",
                                                   "Скверы",
                                                   "Горки",
                                                   "Аквапарки"],
                        collectionViewCellImages: [   "all",
                                                      "parks",
                                                      "miniPark",
                                                      "rollerCoaster",
                                                      "waterPark"],
                        collectionViewCellRequestSubcatNames: [   "amusements",
                                                                  "amusement_parks",
                                                                  "miniature_parks",
                                                                  "roller_coasters",
                                                                  "water_parks"],
                        collectionViewCellRequestSubcatRates: [    "1",
                                                                   "1",
                                                                   "0",
                                                                   "0",
                                                                   "1"])
            // MARK: Case 3
        case 3:
            return Flow(rate: "2",
                        collectionItemName: "accomodations",
                        collectionViewCellNames: [  "Все",
                                                    "Апартаменты",
                                                    "Отели",
                                                    "Хостелы",
                                                    "Курорты"],
                        collectionViewCellImages: [     "all",
                                                        "apartment",
                                                        "hotel",
                                                        "hostel",
                                                        "resort"],
                        collectionViewCellRequestSubcatNames: [  "accomodations",
                                                                 "apartments",
                                                                 "other_hotels",
                                                                 "hostels",
                                                                 "resorts"],
                        collectionViewCellRequestSubcatRates: [ "2",
                                                                "1",
                                                                "1",
                                                                "1",
                                                                "1"])
       
        case 4:
            return Flow(rate: "2",
                        collectionItemName: "sport",
                        collectionViewCellNames: [  "Все",
                                                    "Бассейны",
                                                    "Стадионы",
                                                    "Зимний спорт",
                                                    "Diving",
                                                    "Surfing"],
                        collectionViewCellImages: [   "all",
                                                      "pools",
                                                      "stadium",
                                                      "winterSports",
                                                      "diving",
                                                      "surf"],
                        collectionViewCellRequestSubcatNames: [ "sport",
                                                                "pools",
                                                                "stadiums",
                                                                "winter_sports",
                                                                "diving",
                                                                "surfing"],
                        collectionViewCellRequestSubcatRates: [ "2",
                                                                "1",
                                                                "1",
                                                                "0",
                                                                "0",
                                                                "0"])
            
        case 5:
            return Flow(rate: "1",
                        collectionItemName: "adult",
                        collectionViewCellNames: [ "Все",
                                                   "Алкоголь",
                                                   "Казино",
                                                   "Кальянные",
                                                   "Ночные клубы"],
                        collectionViewCellImages: [ "all",
                                                    "alcohol",
                                                    "casino",
                                                    "hookah",
                                                    "nightClub"],
                        collectionViewCellRequestSubcatNames: ["adult",
                                                               "alcohol",
                                                               "casino",
                                                               "hookah",
                                                               "nightclubs"],
                        collectionViewCellRequestSubcatRates: [  "1",
                                                                 "1",
                                                                 "3",
                                                                 "0",
                                                                 "1"])
        default:
            fatalError()
        }
    }
}
