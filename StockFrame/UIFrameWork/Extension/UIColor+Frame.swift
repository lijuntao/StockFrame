//
//  UIColor+Extension.swift
//  StockFrame
//
//  Created by fdt on 2018/6/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(alpha: CGFloat, red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(netHex:Int, alpha: CGFloat) {
        self.init(alpha: alpha, red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init (wmColor:FDTWMColor, alpha: CGFloat) {
        self.init(netHex:wmColor.rawValue.intValue, alpha: alpha)
    }
    
    convenience init(wmColor:FDTWMColor){
        self.init(netHex:wmColor.rawValue.intValue, alpha: 1)
    }
}


