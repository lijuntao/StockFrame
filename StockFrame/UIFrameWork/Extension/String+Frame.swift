//
//  String+Extension.swift
//  StockFrame
//
//  Created by fdt on 2018/6/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

extension String {
    
    //字符串转Int
    var integer: Int {
        get {
            if let value = Int(self) {
                return value
            } else {
                FDTLog.logInfo("string->int 转换失败 \(self).")
                return 0
            }
        }
    }
}
