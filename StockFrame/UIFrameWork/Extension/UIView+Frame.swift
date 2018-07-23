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
    
    func addTopLine() -> UIView{
        let line = UIView()
        line.backgroundColor = FDTWMColor.backgroundColor.color
        let _ = self + line
        line.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(Layout.ui.regularSeparatorHeight)
        }
        return line;
    }
    
    func addTopLineWithMargin(_ leftMargin:CGFloat = Layout.ui.regularOffsetX, rightMargin:CGFloat = Layout.ui.regularOffsetX) -> UIView{
        let line = UIView()
        line.backgroundColor = FDTWMColor.backgroundColor.color
        let _ = self + line
        line.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(leftMargin)
            make.right.equalTo(self).offset(-rightMargin)
            make.top.equalTo(self)
            make.height.equalTo(Layout.ui.regularSeparatorHeight)
        }
        return line;
    }
    
    func addBottomLine() -> UIView{
        let line = UIView()
        line.backgroundColor = FDTWMColor.backgroundColor.color
        let _ = self + line
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(Layout.ui.regularSeparatorHeight)
        }
        return line;
    }
    
    func addBottomLineWithMargin(_ leftMargin:CGFloat = Layout.ui.regularOffsetX, rightMargin:CGFloat = Layout.ui.regularOffsetX) -> UIView{
        let line = UIView()
        line.backgroundColor = FDTWMColor.backgroundColor.color
        let _ = self + line
        line.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(leftMargin)
            make.right.equalTo(self).offset(-rightMargin)
            make.bottom.equalTo(self)
            make.height.equalTo(Layout.ui.regularSeparatorHeight)
        }
        return line;
    }
}
