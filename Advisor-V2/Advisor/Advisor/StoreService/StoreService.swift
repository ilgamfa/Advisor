//
//  StoreService.swift
//  Advisor_V2
//
//  Created by Ilgam Akhmatdinov on 15.06.2022.
//

import Foundation
import RealmSwift

class RealmAttraction: Object {
    @objc dynamic var xid: String?
    @objc dynamic var name: String?
    @objc dynamic var address: RealmAddessAttraction?
    @objc dynamic var kinds: String?
    @objc dynamic var preview: RealmPreviewAttraction?
    @objc dynamic var wikipedia_extracts: RealmWikiAttraction?
    @objc dynamic var point: RealmPointAttraction?
    
    override class func primaryKey() -> String? {
        return "xid"
    }
}

class RealmAddessAttraction: Object {
    @objc dynamic var state: String?
    @objc dynamic var city: String?
    @objc dynamic var road: String?
    @objc dynamic var house_number: String?
}

class RealmPreviewAttraction: Object {
    @objc dynamic var source: String?
}

class RealmWikiAttraction: Object {
    @objc dynamic var text: String?
}

class RealmPointAttraction: Object {
    @objc dynamic var lat = 0.0
    @objc dynamic var lon = 0.0
}


class StoreService {
    
    lazy var realm: Realm = {
        return try! Realm()
    }()
    
    var attraction = RealmAttraction()
    
    func checkExist(xid: String) -> Bool {
        return realm.object(ofType: RealmAttraction.self, forPrimaryKey: xid) != nil
    }
    
    func writeAttraction(xid: String, name: String?) {
        attraction.xid = xid
        attraction.name = name ?? ""
        try! realm.write({
            realm.add(attraction)
        })
    }
    
    func deleteAttraction(xid: String) {
        if let object = realm.object(ofType: RealmAttraction.self, forPrimaryKey: xid) {
            try! realm.write {
                realm.delete(object)
            }
        }
    }
    
    func getAttractions(completion: @escaping (Result<Results<RealmAttraction>, Error>) -> Void) {
        let results =  realm.objects(RealmAttraction.self)
        completion(.success(results))
    }
}
