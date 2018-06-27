//
//  FDTEntry.swift
//  StockFrame
//
//  Created by fdt on 2018/6/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class FDTEntry: NSObject {
    static let sharedInstance = FDTEntry.init()
    
    var inited: Bool!
    var fdtWindow: FDTUIWindow!
    
    override init() {
        super.init()
        inited = false
        self.initSelf()
    }
    
    func initSelf() {
        if inited == false {
            fdtWindow = FDTUIWindow(frame: UIScreen.main.bounds)
            inited = true
        }
    }
    
    func show() {
        if self.inited {
            self.initSelf()
        }
        self.createUI()
        
        fdtWindow.makeKeyAndVisible()
    }
    
    private func createUI() {
        fdtWindow.rootViewController = FDTUIFrameWork.sharedInstance.shareingUIFramework().mainTabBar
    }
}
