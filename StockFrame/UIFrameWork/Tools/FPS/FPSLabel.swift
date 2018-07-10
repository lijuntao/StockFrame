//
//  FPSLabel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/10.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit
import SnapKit
class FPSLabel: NSObject {
    
    class func show() {
        let fps_lab = YYFPSLabel()
        if let rootView = UIApplication.shared.keyWindow {
            rootView.addSubview(fps_lab)
            var offset = 0
            if FDTTools.isIphoneX() {
                offset = 34
            }
            fps_lab.snp.makeConstraints({ (make) in
                make.top.equalTo(rootView).offset(offset);
                make.right.equalTo(rootView.snp.right).offset(-50);
            })
        }
    }
}
