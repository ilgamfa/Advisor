//
//  TripApiTargetType.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 02.05.2022.
//

import Foundation
import Moya

enum TripApiTargetType {
    case fetchData(rate: String, kind: String, radius: String, longitude: String, latitude: String, limit: String, apiKey: String)
    case fetchDetailData(xid: String, apikey: String)
}

extension TripApiTargetType: TargetType {
    var baseURL: URL {
        switch self {
        case .fetchData, .fetchDetailData:
            guard let url = URL(string: "https://api.opentripmap.com/0.1/en/places/") else { fatalError("baseURL could not be configured")}
            return url
        }
    }
    
    var path: String {
        switch self {
        case .fetchData:
            return "radius"
        case .fetchDetailData(let xid, _):
            return "xid/\(xid)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchData, .fetchDetailData:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .fetchData(rate, kind, radius, longitude, latitude, limit, apiKey):
            var parameters: [String: Any] = [:]
            parameters["radius"] = radius
            parameters["lon"] = longitude
            parameters["lat"] = latitude
            parameters["kinds"] = kind
            parameters["rate"] = rate
            parameters["format"] = "json"
            parameters["limit"] = limit
            parameters["apikey"] = apiKey
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case let .fetchDetailData(_, apikey):
            return .requestParameters(parameters: ["apikey" : apikey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
