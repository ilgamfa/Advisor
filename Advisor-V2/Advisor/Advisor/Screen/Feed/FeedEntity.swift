//
//  FeedEntity.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation
import UIKit

protocol FeedEntityProtocol {
    func getFlow(indexPath: Int) -> Flow
}

struct Flow {
    let rate: String
    let collectionItemName: String
    let collectionViewCellNames: [String]
    let collectionViewCellImages: [String]
    let collectionViewCellRequestSubcatNames: [String]
    let collectionViewCellRequestSubcatRates: [String]
    
}

class FeedEntity: FeedEntityProtocol {
    func getFlow(indexPath: Int) -> Flow {
        switch indexPath {
        case 0:
            return Flow(rate: "1h",
                        collectionItemName: "interesting_places",
                        collectionViewCellNames: [ "All",
                                                   "Architecture",
                                                   "Cultural",
                                                   "Historical",
                                                   "Industrial facilities",
                                                   "Natural",
                                                   "Other",
                                                   "Religion"],
                        collectionViewCellImages: [ "all",
                                                    "architecture",
                                                    "culture",
                                                    "historical",
                                                    "industrial",
                                                    "nature",
                                                    "other",
                                                    "religion"],
                        collectionViewCellRequestSubcatNames: [ "interesting_places",
                                                                "architecture",
                                                                "cultural",
                                                                "historic",
                                                                "industrial_facilities",
                                                                "natural",
                                                                "other",
                                                                "religion"],
                        collectionViewCellRequestSubcatRates: [ "",
                                                                "1h",
                                                                "3",
                                                                "3",
                                                                "1",
                                                                "3",
                                                                "1",
                                                                "3",])

        case 1:
            return Flow(rate: "1",
                        collectionItemName: "tourist_facilities",
                        collectionViewCellNames: [ "All",
                                                   "Banks",
                                                   "Foods",
                                                   "Shops",
                                                   "Transport"],
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
                        collectionViewCellRequestSubcatRates: [     "",
                                                                    "1",
                                                                    "1",
                                                                    "1",
                                                                    "1"])
            
        case 2:
            return Flow(rate: "1",
                        collectionItemName: "amusements",
                        collectionViewCellNames: [ "All",
                                                   "Parks",
                                                   "Ferris wheels",
                                                   "Mini parks",
                                                   "Roller coaster",
                                                   "Water parks"],
                        collectionViewCellImages: [   "all",
                                                      "parks",
                                                      "ferrisWheel",
                                                      "miniPark",
                                                      "rollerCoaster",
                                                      "waterPark"],
                        collectionViewCellRequestSubcatNames: [   "amusements",
                                                                  "amusement_parks",
                                                                  "ferris_wheels",
                                                                  "miniature_parks",
                                                                  "roller_coasters",
                                                                  "water_parks"],
                        collectionViewCellRequestSubcatRates: [    "",
                                                                   "1",
                                                                   "0",
                                                                   "0",
                                                                   "0",
                                                                   "1"])
            // MARK: Case 3
        case 3:
            return Flow(rate: "2",
                        collectionItemName: "accomodations",
                        collectionViewCellNames: [  "All",
                                                    "Apartments",
                                                    "Hotels",
                                                    "Hostels",
                                                    "Resorts",
                                                    "Villas and chalet"],
                        collectionViewCellImages: [     "all",
                                                        "apartment",
                                                        "hotel",
                                                        "hostel",
                                                        "resort",
                                                        "villas"],
                        collectionViewCellRequestSubcatNames: [  "accomodations",
                                                                 "apartments",
                                                                 "other_hotels",
                                                                 "hostels",
                                                                 "resorts",
                                                                 "villas_and_chalet"],
                        collectionViewCellRequestSubcatRates: [ "",
                                                                "1",
                                                                "1",
                                                                "1",
                                                                "1",
                                                                "1"])
       
        case 4:
            return Flow(rate: "2",
                        collectionItemName: "sport",
                        collectionViewCellNames: [  "All",
                                                    "Pools",
                                                    "Stadiums",
                                                    "Winter sport",
                                                    "Climbind",
                                                    "Diving",
                                                    "Kitesurfing",
                                                    "Surfing"],
                        collectionViewCellImages: [   "all",
                                                      "pools",
                                                      "stadium",
                                                      "winterSports",
                                                      "climbing",
                                                      "diving",
                                                      "kitesurfing",
                                                      "surf"],
                        collectionViewCellRequestSubcatNames: [ "sport",
                                                                "pools",
                                                                "stadiums",
                                                                "winter_sports",
                                                                "climbing",
                                                                "diving",
                                                                "kitesurfing",
                                                                "surfing"],
                        collectionViewCellRequestSubcatRates: [ "",
                                                                "1",
                                                                "1",
                                                                "0",
                                                                "1",
                                                                "0",
                                                                "0",
                                                                "0"])
            
        case 5:
            return Flow(rate: "1",
                        collectionItemName: "adult",
                        collectionViewCellNames: [ "All",
                                                   "Alcohol",
                                                   "Casino",
                                                   "Hookah",
                                                   "Night clubs"],
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
                        collectionViewCellRequestSubcatRates: [  "",
                                                                 "1",
                                                                 "3",
                                                                 "0",
                                                                 "1"])
        default:
            fatalError()
        }
    }
}
