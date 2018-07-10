//
//  FDT_UI_Public_Proxy.swift
//  StockFrame
//
//  Created by fdt on 2018/6/28.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

class FDT_UI_Public_Proxy {
    
    // MARK: 设置 key + 值
    
    /*
        公用数据存储 key + value 的方式。
        应用场景：构件间通信时，想保留特殊的内存内容，以后来使用或者其他构件使用
        注意，使用不要过度，不利用的时候要移除。另外，注意命名
     */
    class func SetPublicValue(forKey key: String,value: AnyObject) {
        FDTUIFrameWork.sharedInstance.setPublicValue(forKey: key, value: value)
    }
    
    class func GetPublicValue(forKey key: String) -> AnyObject? {
        return FDTUIFrameWork.sharedInstance.getPublicValue(forKey:key)
    }
    
    class func RemovePublicValue(forKey key: String) {
        FDTUIFrameWork.sharedInstance.removePublicValue(forKey: key)
    }
    
    class func getPopNavigationVC() -> NavigationControllerBase {
        return FDTUIFrameWork.sharedInstance.getPopNavigationController()
    }
    
    // MARK: UI跳转
    class func GotoVCWithId(_ id: Int) {
        FDT_UI_Public_Proxy.GoToVCWithId(id, params: nil)
    }
    
    class func GoToVCWithId(_ id: Int, params: Dictionary<String, AnyObject>?) {
        FDTUIFrameWork.sharedInstance.goToVCWithId(id, params: params)
    }
    
    class func showFPS() {
        FPSLabel.show()
    }
}
