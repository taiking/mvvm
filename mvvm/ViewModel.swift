//
//  ViewModel.swift
//  mvvm
//
//  Created by 辻林大揮 on 2018/07/18.
//  Copyright © 2018年 chocovayashi. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewModel {
    
    private let model = Model()
    
    let entities = BehaviorRelay<[Entity]>(value: [])
    
    private let bag = DisposeBag()
    
    func getAndSave() {
        let requestAndSave = model.get()
            .flatMap { entities -> Observable<[Entity]> in
                self.model.save(entities: entities)
                return Observable.just(entities)
        }
        
        Observable
            .concat(model.getFromRealm(), requestAndSave)
            .bind(to: entities)
            .disposed(by: bag)
    }
}
