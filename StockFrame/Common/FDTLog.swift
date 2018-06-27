//
//  FDTLog.swift
//  StockFrame
//
//  Created by 李俊涛 on 2018/6/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation
import CocoaLumberjack
class FDTLog {
    
    class func initLog() {
        #if DEBUG
            defaultDebugLevel = .all
            DDLog.add(DDTTYLogger.sharedInstance)
        #else
            defaultDebugLevel = .error
            DDLog.add(DDASLLogger.sharedInstance)
        #endif
        
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
    
    class func logVerbose(_ message: String) {
        DDLogVerbose(message)
    }
    
    class func logDebug(_ message: String) {
        DDLogDebug(message)
    }
    
    class func logInfo(_ message: String) {
        DDLogInfo(message)
    }
    
    class func logWarn(_ message: String) {
        DDLogWarn(message)
    }
    
    class func logError(_ message: String) {
        DDLogError(message)
    }
}
