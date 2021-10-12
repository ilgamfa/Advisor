//
//  AttractionDetailModel.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 06.10.2021.
//

import Foundation

struct AttractionDetail: Decodable {
    var name: String?
    var kinds: String?
    var preview: Preview?
    var wikipedia_extracts: WikiExtracts?
    var point: Point?
}

enum CodingKeys: String, CodingKey {
    case xid, name, kinds, preview
//    Не работает вот так
//    case wikipediaExtracts = "wikipedia_extracts"
//    Так работает
    case wikipedia_extracts
    case point
}

struct Preview: Decodable {
    var source: String?
}

struct WikiExtracts: Decodable {
    var text: String?
}
