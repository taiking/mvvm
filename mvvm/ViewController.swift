//
//  ViewController.swift
//  mvc
//
//  Created by 辻林大揮 on 2018/07/12.
//  Copyright © 2018年 chocovayashi. All rights reserved.
//

import UIKit
import RxSwift
import APIKit
import RealmSwift

class ViewController: UIViewController {
    
    private let bag = DisposeBag()
    
    @IBOutlet weak private var label: UILabel!
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getTrigger.on(.next(()))
        
        viewModel.models.subscribe(onNext: { [unowned self] models in
            self.setView(models)
        }).disposed(by: bag)
    }
    
    private func setView(_ models: [Model]) {
        label.text = models
            .map { "name: \($0.owner.name), name: \($0.repositoryName)\n" }
            .reduce("") { $0 + $1 }
    }
}
