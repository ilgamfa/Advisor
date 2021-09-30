//
//  ObjectOnMap.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 30.09.2021.
//

import Foundation

struct Attraction: Decodable {
    var name: String?
    var point: Point 
}

struct Point: Decodable {
    var lat: Double
    var lon: Double
}

