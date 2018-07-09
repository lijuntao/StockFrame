//
//  BaseBarButtonItem.swift
//  StockFrame
//
//  Created by fdt on 2018/7/9.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class BaseBarButtonItem: UIBarButtonItem {
    override init() {
        super.init()
        self.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: FDTWMColor.statusBarColor.color], for: UIControlState())
        self.setBarButtonItemTitleColor(FDTWMColor.statusBarColor.color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setBarButtonItemTitleColor(_ color: UIColor) {
        self.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: color], for: UIControlState())
    }
}
