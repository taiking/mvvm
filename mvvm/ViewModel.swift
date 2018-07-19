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
    
    var models: Observable<[Model]> {
        return _models.asObservable()
    }
    
    private let _models = BehaviorRelay<[Model]>(value: [])
    
    let getTrigger = PublishSubject<Void>()
    let realm: Realm
    
    init() {
        self.realm = try! Realm()
        
        getTrigger
            .flatMap { [unowned self] () -> Observable<[Model]> in
                let requestAndSave = Session.sendRequest(request: GetRequest())
                    .flatMap { models -> Observable<[Model]> in
                        try! self.realm.write {
                            self.realm.delete(self.realm.objects(Model.self))
                            self.realm.add(models)
                        }
                        return Observable.just(models)
                }
                return Observable
                    .concat(Observable.just(Array(self.realm.objects(Model.self))), requestAndSave)
            }
            .bind(to: _models)
            .disposed(by: bag)
    }
}
