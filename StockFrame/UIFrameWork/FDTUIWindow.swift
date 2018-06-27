//
//  FDTUIWindow.swift
//  StockFrame
//
//  Created by fdt on 2018/6/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class FDTUIWindow: UIWindow {

    func initFDTWindow() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidReceiveMemoryWarning(_:)), name: .UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
