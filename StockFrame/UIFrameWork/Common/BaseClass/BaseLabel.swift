//
//  BaseLabel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.7;
        self.lineBreakMode = .byTruncatingTail
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class LabelTextAlignmentLeft: BaseLabel {
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.textAlignment = NSTextAlignment.left
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class LabelTextAlignmentRight: BaseLabel {
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.textAlignment = NSTextAlignment.right
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class LabelTextAlignmentCenter: BaseLabel {
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.textAlignment = NSTextAlignment.center
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
