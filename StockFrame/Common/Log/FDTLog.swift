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
        
        
            // 添加DDFileLogger，你的日志语句将写入到一个文件中，
            // 默认路径在沙盒的Library/Caches/Logs/目录下，文件名为bundleid+空格+日期.log。
            let fileLogger: DDFileLogger = DDFileLogger() // File Logger
            fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
            fileLogger.logFileManager.maximumNumberOfLogFiles = 7
            DDLog.add(fileLogger)
        #endif
    }
    
    class func logVerbose(_ message: String) {
        DDLogVerbose(message)
    }
    
    class func logDebug(_ message: String) {
        DDLogDebug(message)
    }
    
    class func logInfo(_ message: String, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
        DDLogInfo("\((fileName as NSString).lastPathComponent) 方法:\(methodName) 行号:\(lineNumber) 信息: \(message)")
    }
    
    class func logWarn(_ message: String, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
        DDLogWarn("\((fileName as NSString).lastPathComponent) 方法:\(methodName) 行号:\(lineNumber) 信息: \(message)")
    }
    
    class func logError(_ message: String, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
        DDLogError("\((fileName as NSString).lastPathComponent) 方法:\(methodName) 行号:\(lineNumber) 信息: \(message)")
    }
}
