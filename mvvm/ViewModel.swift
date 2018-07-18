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

class ViewModel {
    
    private let bag = DisposeBag()
    
    let models = BehaviorRelay<[Model]>(value: [])
    
    func get() {
        let realm = try! Realm()
        let requestAndSave = Session.sendRequest(request: GetRequest())
            .flatMap { models -> Observable<[Model]> in
                try! realm.write {
                    realm.delete(realm.objects(Model.self))
                    realm.add(models)
                }
                return Observable.just(models)
        }
        
        Observable
            .concat(Observable.just(Array(realm.objects(Model.self))), requestAndSave)
            .bind(to: models)
            .disposed(by: bag)
    }
}
