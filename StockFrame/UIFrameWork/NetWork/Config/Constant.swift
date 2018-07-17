//
//  Constant.swift
//  StockFrame
//
//  Created by fdt on 2018/7/17.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

enum Constant {
    /// 一般通用字串
    enum string {
        static let invalid:String = "-"
        static let invalidDoubleDash:String = "--"
        static let percent:String = "%"
    }
    
    enum system {
        /// 產品代號
        static let productName = "FDTSecurities"
        
        /// 版本號
        static let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        /// Build
        static let buildNumber = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
        /// uuid
        static let uuid = UUID().uuidString
        /// 平台
        static let platform = "iOS"
        /// scheme
        static let scheme = "fdtsecurities"
        
        static let country = "CN"
        static let language = "CN"
    }
}
