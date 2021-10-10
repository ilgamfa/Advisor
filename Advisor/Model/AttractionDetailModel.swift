//
//  AttractionDetailModel.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 06.10.2021.
//

import Foundation

struct AnnotationDetals {
    var xid: String
    var name: String?
    var address: Address
    var rate: String
    var kinds: String
    var image: String
    var preview: Preview
    var wikipediaExtracts: WikiExtracts
    var point: Point
}

 struct Address {
    var country: String
    var city: String
    var road: String
    var houseNumber: String
}

struct Preview {
    var source: String
    var height: Int
    var width: Int
}

struct WikiExtracts {
    var title: String
    var text: String
}
