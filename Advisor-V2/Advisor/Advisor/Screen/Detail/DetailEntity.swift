//
//  DetailEntity.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 02.05.2022.
//

import Foundation

struct AttractionDetail: Decodable {
    var name: String?
    var address: Address?
    var kinds: String?
    var preview: Preview?
    var wikipedia_extracts: WikiExtracts?
    var point: Point?
}

enum CodingKeys: String, CodingKey {
    case xid, name, kinds, preview
    case wikipedia_extracts
    case point
}

struct Address: Decodable {
    var state: String?
    var city: String?
    var road: String?
    var house_number: String?
}

struct Preview: Decodable {
    var source: String?
}

struct WikiExtracts: Decodable {
    var text: String?
}
