//
//  FDTTools.swift
//  StockFrame
//
//  Created by fdt on 2018/7/5.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class FDTTools: NSObject {
    class func isIphoneX() -> Bool {
        if UIDevice.current.modelName == "iPhone X" {
            return true
        }
        return false
    }
    
    class func isPlusModel() -> Bool {
        if UIDevice.current.modelName.contains("Plus") {
            return true
        }
        return false
    }
    
    class func getRiseOrFallColor(_ value: NSNumber!) -> UIColor {        
        if value.floatValue > 0 {
            return UIColor.init(wmColor: FDTWMColor.valueRiseColor)
        } else if value.floatValue < 0 {
            return UIColor.init(wmColor: FDTWMColor.valueFallColor)
        } else {
            return UIColor.init(wmColor: FDTWMColor.unchangeColor)
        }
    }
    
    class func getRiseOrFallColorDecValue(_ decValue: NSDecimalNumber!) -> UIColor {
        return getRiseOrFallColor(NSNumber.init(value: decValue.floatValue as Float))
    }
    
    class func getMarketCloseColor() -> UIColor {
        return UIColor.init(wmColor: FDTWMColor.marketCloseColor)
    }
    
    class func check(_ text:String!) -> Bool {
        if let a:String =  text{
            if let _ = Float(a){
                return true
            }
        }
        return false
    }
    
    class func convertToNSNumber(_ text:String!) -> NSNumber {
        
        if check(text) {
            return NSNumber(value: Float(text)! as Float)
        }
        return 0
    }
    
    class func getSymbolShortId(_ strSymbolID: String) -> String{
        let array = strSymbolID.components(separatedBy: ".")
        if array.count > 0 {
            return array[0]
        }
        return ""
    }
    
    /// 根据symbolId 获取市场
    ///
    /// - Parameter symbolId: symbolID
    /// - Returns: 市场字符串
    class func getMarketWithSymbolId(_ symbolId:String) -> String {
        let splitArray = symbolId.components(separatedBy: ".")
        if splitArray.count >= 3 { //取倒数第二个，市场字段
            return splitArray[splitArray.count - 2];
        }
        return ""
    }
}
