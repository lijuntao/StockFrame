//
//  UIImage+Extension.swift
//  StockFrame
//
//  Created by fdt on 2018/6/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func image(_ name: String) -> UIImage {
        return UIImage.init(named: name)!
    }
}
