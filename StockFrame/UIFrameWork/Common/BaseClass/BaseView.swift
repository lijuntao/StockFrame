//
//  BaseView.swift
//  StockFrame
//
//  Created by fdt on 2018/7/11.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = FDTWMColor.whiteColor.color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override class var requiresConstraintBasedLayout : Bool {
        return true;
    }
    
    func activeViewModel() {
        preconditionFailure("This method must be overridden")
    }
    
    func deactiveViewModel() {
        preconditionFailure("This method must be overridden")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
