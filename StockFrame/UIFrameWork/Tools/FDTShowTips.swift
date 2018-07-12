//
//  FDTShowTips.swift
//  StockFrame
//
//  Created by fdt on 2018/7/12.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit
import MBProgressHUD
class FDTShowTips: NSObject {
    
    class func showTipsAuto(text: String, showTime time: Double) {
        let view = UIApplication.shared.keyWindow
        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.mode = .text
        hud.label.text = text
        hud.label.textColor = UIColor.white
        hud.label.font = UIFont.systemFont(ofSize: 15.0)
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: time)
    }
}
