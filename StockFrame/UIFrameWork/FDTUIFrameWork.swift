//
//  FDTUIFrameWork.swift
//  StockFrame
//
//  Created by fdt on 2018/5/25.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class FDTUIFrameWork: NSObject {
    static let sharedInstance = FDTUIFrameWork.init()
    
    var g_UITabFrame:FDTUITabFrame!
    var publicValues:Dictionary<String,Any>! //公共数据存储
    
    override init() {
        publicValues = Dictionary<String, Any>()
    }
    
    deinit {
        publicValues = nil
    }
    
    private func createFrameWorkWithType() -> FDTUITabFrame {
        let uiFrameWork = FDTUITabFrame()
        return uiFrameWork
    }
    
    func shareingUIFramework() -> FDTUITabFrame {
        if g_UITabFrame == nil {
            g_UITabFrame = createFrameWorkWithType()
        }
        return g_UITabFrame!
    }
}
