//
//  ObjectOnMap.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 30.09.2021.
//

import Foundation

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

