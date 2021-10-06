//
//  File.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 06.10.2021.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let name: String?
    let xid: String?
    let kinds: String?
 
    
    init(name: String?, xid: String?, kinds: String, coordinate: CLLocationCoordinate2D) {
       
        self.name = name
        self.xid = xid
        self.kinds = kinds
        self.coordinate = coordinate
        
        super.init()
    }
    
    init?(feature: MKGeoJSONFeature) {
        guard
            let point = feature.geometry.first as? MKPointAnnotation,
            let propertiesData = feature.properties,
            let json = try? JSONSerialization.jsonObject(with: propertiesData),
            let properties = json as? [String: Any]
        else {
            return nil
        }
        
        name = properties["name"] as? String
        xid = properties["xid"] as? String
        kinds = properties["kinds"] as? String
        coordinate = point.coordinate
        super.init()
    }
    
    
    
    var subtitle: String? {
        return kinds
    }
    var title: String? {
        return name
    }
}
