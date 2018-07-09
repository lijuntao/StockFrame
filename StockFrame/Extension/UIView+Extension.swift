//
//  UIView+Extension.swift
//  StockFrame
//
//  Created by fdt on 2018/7/9.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

extension UIView {
    func applyNavBarConstraints(size: CGSize) {
        if #available(iOS 11.0, *) {
            let widthConstraint = self.widthAnchor.constraint(equalToConstant: size.width)
            let heightConstraint = self.heightAnchor.constraint(equalToConstant: size.height)
            heightConstraint.isActive = true
            widthConstraint.isActive = true
        } else {
            // Fallback on earlier versions
        }
        
    }
}
