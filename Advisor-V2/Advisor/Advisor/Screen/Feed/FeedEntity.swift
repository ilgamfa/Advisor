//
//  FeedEntity.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import Foundation
import UIKit

protocol FeedEntityProtocol {
    func getFlow(indexPath: Int)
}

class FeedEntity: FeedEntityProtocol {
    
    private var kind: String = ""
    private var rate: String = ""
    private var collectionItemName = ""
    
    private var collectionViewCellNames = [String]()
    private var collectionViewCellImages = [UIImage]()
    private var collectionViewCellRequestSubcatNames = [String]()
    private var collectionViewCellRequestSubcatRates = [String]()
    
    func getFlow(indexPath: Int) {
        switch indexPath {
        case 0:
            rate = "1h"
            collectionItemName = "interesting_places"
            
            collectionViewCellNames = [
                "All",
                "Architecture",
                "Cultural",
                "Historical",
                "Industrial facilities",
                "Natural",
                "Other",
                "Religion"
            ]
            
            collectionViewCellImages = [
                UIImage(named: "all")!,
                UIImage(named: "architecture")!,
                UIImage(named: "culture")!,
                UIImage(named: "historical")!,
                UIImage(named: "industrial")!,
                UIImage(named: "nature")!,
                UIImage(named: "other")!,
                UIImage(named: "religion")!
            ]
            
            collectionViewCellRequestSubcatNames = [
                "interesting_places",
                "architecture",
                "cultural",
                "historic",
                "industrial_facilities",
                "natural",
                "other",
                "religion"
            ]
            
            collectionViewCellRequestSubcatRates = [
                rate,
                "1h",
                "3",
                "3",
                "1",
                "3",
                "1",
                "3",
            ]
            
            // MARK: Case 1
        case 1:
            rate = "1"
            collectionItemName = "tourist_facilities"
            collectionViewCellNames = [
                "All",
                "Banks",
                "Foods",
                "Shops",
                "Transport"
            ]
            
            collectionViewCellImages = [
                UIImage(named: "all")!,
                UIImage(named: "banks")!,
                UIImage(named: "foods")!,
                UIImage(named: "shops")!,
                UIImage(named: "transport")!
            ]
            
            collectionViewCellRequestSubcatNames = [
                "tourist_facilities",
                "banks",
                "foods",
                "shops",
                "transport"
            ]
            
            collectionViewCellRequestSubcatRates = [
                rate,
                "1",
                "1",
                "1",
                "1"
            ]
            
            // MARK: Case 2
        case 2:
            rate = "1"
            collectionItemName = "amusements"
            collectionViewCellNames = [
                "All",
                "Parks",
                "Ferris wheels",
                "Mini parks",
                "Roller coaster",
                "Water parks"
            ]
            
            collectionViewCellImages = [
                UIImage(named: "all")!,
                UIImage(named: "parks")!,
                UIImage(named: "ferrisWheel")!,
                UIImage(named: "miniPark")!,
                UIImage(named: "rollerCoaster")!,
                UIImage(named: "waterPark")!
            ]
        
            collectionViewCellRequestSubcatNames = [
                "amusements",
                "amusement_parks",
                "ferris_wheels",
                "miniature_parks",
                "roller_coasters",
                "water_parks"
            ]
            
            collectionViewCellRequestSubcatRates = [
                rate,
                "1",
                "0",
                "0",
                "0",
                "1"
            ]
            
            // MARK: Case 3
        case 3:
            rate = "2"
            collectionItemName = "accomodations"
            collectionViewCellNames = [
                "All",
                "Apartments",
                "Hotels",
                "Hostels",
                "Resorts",
                "Villas and chalet"
            ]
            
            collectionViewCellImages = [
                UIImage(named: "all")!,
                UIImage(named: "apartment")!,
                UIImage(named: "hotel")!,
                UIImage(named: "hostel")!,
                UIImage(named: "resort")!,
                UIImage(named: "villas")!
            ]
            
            collectionViewCellRequestSubcatNames = [
                "accomodations",
                "apartments",
                "other_hotels",
                "hostels",
                "resorts",
                "villas_and_chalet"
            ]
            
            collectionViewCellRequestSubcatRates = [
                rate,
                "1",
                "1",
                "1",
                "1",
                "1"
            ]
            
            // MARK: Case 4
        case 4:
            rate = "2"
            collectionItemName = "sport"
            collectionViewCellNames = [
                "All",
                "Pools",
                "Stadiums",
                "Winter sport",
                "Climbind",
                "Diving",
                "Kitesurfing",
                "Surfing"
            ]
            
            collectionViewCellImages = [
                UIImage(named: "all")!,
                UIImage(named: "pools")!,
                UIImage(named: "stadium")!,
                UIImage(named: "winterSports")!,
                UIImage(named: "climbing")!,
                UIImage(named: "diving")!,
                UIImage(named: "kitesurfing")!,
                UIImage(named: "surf")!
            ]
            
            collectionViewCellRequestSubcatNames = [
                "sport",
                "pools",
                "stadiums",
                "winter_sports",
                "climbing",
                "diving",
                "kitesurfing",
                "surfing"
            ]
            
            collectionViewCellRequestSubcatRates = [
                rate,
                "1",
                "1",
                "0",
                "1",
                "0",
                "0",
                "0",
            ]
            
            // MARK: Case 5
        case 5:
            rate = "1"
            collectionItemName = "adult"
            collectionViewCellNames = [
                "All",
                "Alcohol",
                "Casino",
                "Hookah",
                "Night clubs"
            ]
            
            collectionViewCellImages = [
                UIImage(named: "all")!,
                UIImage(named: "alcohol")!,
                UIImage(named: "casino")!,
                UIImage(named: "hookah")!,
                UIImage(named: "nightClub")!
            ]
            
            collectionViewCellRequestSubcatNames = [
                "adult",
                "alcohol",
                "casino",
                "hookah",
                "nightclubs"
            ]
            
            collectionViewCellRequestSubcatRates = [
                rate,
                "1",
                "3",
                "0",
                "1"
            ]
            
            // MARK: Case Default
        default:
            collectionItemName = ""
        }
    }
}
