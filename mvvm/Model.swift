//
//  Model.swift
//  mvc
//
//  Created by 辻林大揮 on 2018/07/12.
//  Copyright © 2018年 chocovayashi. All rights reserved.
//

import RxSwift
import RealmSwift
import APIKit

class Model {
    
    func getFromRealm() -> Observable<[Entity]> {
        let realm = try! Realm()
        return Observable.just(Array(realm.objects(Entity.self)))
    }
    
    func get() -> Observable<[Entity]> {
        return Session.shared.sendRequest(request: GetRequest())
    }
    
    func save(entities: [Entity]) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(Entity.self))
            realm.add(entities)
        }
    }
}
