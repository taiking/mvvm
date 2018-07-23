//
//  ViewController.swift
//  mvc
//
//  Created by 辻林大揮 on 2018/07/12.
//  Copyright © 2018年 chocovayashi. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    private let bag = DisposeBag()
    
    @IBOutlet weak private var customView: View!
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getAndSave()
        
        viewModel.entities.subscribe(onNext: { [unowned self] entities in
            print(entities)
            self.customView.setView(entities)
        }).disposed(by: bag)
    }
}
