//
//  BaseViewModel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/11.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

protocol ViewModelProtocol: NSObjectProtocol {
    func refreshUI()
}

class BaseViewModel: NSObject {
    
    weak var delegate: ViewModelProtocol?
    
    override init() {
        super.init()
    }
    
    func active() {
        preconditionFailure("This method must be overridden")
    }
    
    func deactive() {
        preconditionFailure("This method must be overridden")
    }
    
    func notifiedToUI () {
        delegate?.refreshUI()
    }
}
