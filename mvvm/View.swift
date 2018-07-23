//
//  View.swift
//  mvvm
//
//  Created by 辻林大揮 on 2018/07/19.
//  Copyright © 2018年 chocovayashi. All rights reserved.
//

import UIKit

class View: UIView {
    
    @IBOutlet weak private var label: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        guard let headerView = Bundle.main.loadNibNamed("View", owner: self, options: nil)?.first as? UIView else {
            return
        }
        headerView.frame = self.bounds
        self.addSubview(headerView)
    }
    
    func setView(_ entities: [Entity]) {
        label.text = entities
            .map { "name: \($0.owner.name), name: \($0.repositoryName)\n" }
            .reduce("") { $0 + $1 }
    }
}
