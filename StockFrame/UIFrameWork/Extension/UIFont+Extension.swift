//
//  UIFont+Extension.swift
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

extension UIFont {
    public class func pingFangSCRegularFontOfSize(_ fontSize: CGFloat) -> UIFont{
        return self.pingFontAndSize("PingFangSC-Regular", size: fontSize)
    }
    
    public class func pingFangSCMediumFontOfSize(_ fontSize: CGFloat) -> UIFont{
        return self.pingFontAndSize("PingFangSC-Medium", size: fontSize)
    }
    
    public class func pingFangSCLightFontOfSize(_ fontSize: CGFloat) -> UIFont{
        return self.pingFontAndSize("PingFangSC-Light", size: fontSize)
    }
    
    public class func dinRegularFontOfSize(_ fontSize: CGFloat) -> UIFont{
        return self.pingFontAndSize("DIN-Regular", size: fontSize)
    }
    
    public class func dinLightFontOfSize(_ fontSize: CGFloat) -> UIFont{
        return self.pingFontAndSize("DIN-Light", size: fontSize)
    }
    
    fileprivate class func pingFontAndSize(_ font: String, size: CGFloat) -> UIFont {
        
        return UIFont.systemFont(ofSize: size)
        
//        if #available(iOS 9.0, *) {
//            return UIFont(name: font, size: fontSize)!
//        } else {
//            return UIFont.systemFont(ofSize: size)
//        }
    }
}
