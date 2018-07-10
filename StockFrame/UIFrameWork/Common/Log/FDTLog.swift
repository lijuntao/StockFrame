//
//  FDTLog.swift
//  StockFrame
//
//  Created by 李俊涛 on 2018/6/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation
class FDTLog {
    
    class func initLog() {
        DLog.initLog()
    }
    
    
    class func logDebug(_ message: String) {
        DLog.logDebug(message)
    }
    
    class func logInfo(_ message: String, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
        DLog.logInfo("\((fileName as NSString).lastPathComponent) 方法:\(methodName) 行号:\(lineNumber) 信息: \(message)")
    }
}
