//
//  ObjectOnMap.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 30.09.2021.
//

import Foundation
struct AttractionData: Decodable {
    let attractions: [Attraction]
}


struct Attraction: Decodable {
    var name: String?
    var point: Point
    var xid: String
    var kinds: String
}

struct Point: Decodable {
    var lat: Double
    var lon: Double
}

