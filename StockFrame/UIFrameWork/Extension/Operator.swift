//
//  Operator.swift
//  FDTCapital
//
//  Created by bmcool on 2016/3/29.
//  Copyright © 2016年 hkfdt. All rights reserved.
//

import Foundation

infix operator +

func + (parent: UIView, child: UIView) -> UIView {
    parent.addSubview(child)
    return parent
}
func + (parent: UIView, childs: Array<UIView>) -> UIView {
    for child in childs {
        parent.addSubview(child)
    }
    return parent
}
