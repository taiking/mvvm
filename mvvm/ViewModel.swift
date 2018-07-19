//
//  ViewModel.swift
//  mvvm
//
//  Created by 辻林大揮 on 2018/07/18.
//  Copyright © 2018年 chocovayashi. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift
import APIKit
import Action

class ViewModel {
    
    let getAction: Action<Void, [Model]>
    
    init() {
        let realm = try! Realm()
        getAction = Action<Void, [Model]> { _ -> Observable<[Model]> in
                let requestAndSave = Session.sendRequest(request: GetRequest())
                    .flatMap { models -> Observable<[Model]> in
                        try! realm.write {
                            realm.delete(realm.objects(Model.self))
                            realm.add(models)
                        }
                        return Observable.just(models)
                }
                return Observable
                    .concat(Observable.just(Array(realm.objects(Model.self))), requestAndSave)
        }
    }
}
