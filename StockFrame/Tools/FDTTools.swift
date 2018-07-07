//
//  FDTTools.swift
//  StockFrame
//
//  Created by fdt on 2018/7/5.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class FDTTools: NSObject {
    class func isIphoneX() -> Bool {
        if UIDevice.current.modelName == "iPhone X" {
            return true
        }
        return false
    }
    
    class func isPlusModel() -> Bool {
        if UIDevice.current.modelName.contains("Plus") {
            return true
        }
        return false
    }
}
