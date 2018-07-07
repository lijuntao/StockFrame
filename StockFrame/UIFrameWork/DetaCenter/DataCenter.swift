//
//  DataCenter.swift
//  StockFrame
//
//  Created by fdt on 2018/7/5.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class DataCenter: NSObject, DataManagerDelegate {
    
    static let sharedInstance = DataCenter()
    
    var dataManager: DataManager!
    
    override init() {
        super.init()
    }
    
    func active() {
        if dataManager == nil {
            dataManager = DataManager.init()
            dataManager.delegate = self
        }
    }
    
    func doSuspend() {
        if dataManager != nil {
            dataManager.doSuspend()
            dataManager.stopAliveForSender()
        }
    }
    
    func doResume() {
        if dataManager != nil {
            dataManager.doResume()
            dataManager.startAliveForSender()
        }
        
    }
    func doLogout() {
        self.dataManager.doLogout()
    }
    
    //加载server配置信息
    func loadLoacalBundle() {
        ServerConfig.sharedInstance.updateConfig("test")
    }
    
    //MARK: DataManagerDelegate
    func getHostType(_ type: ServerType) -> String {
        switch type {
        case .ENUM_LOGINSERVER:
            return ServerConfig.sharedInstance.loginIP
        case .ENUM_QUOTESERVER:
            return ServerConfig.sharedInstance.quoteIP
        case .ENUM_TRADESERVER:
            return ServerConfig.sharedInstance.tradeIP
        }
    }
    
    func getPortType(_ type: ServerType) -> String {
        switch type {
        case .ENUM_LOGINSERVER:
            return String(ServerConfig.sharedInstance.loginPort)
        case .ENUM_QUOTESERVER:
            return String(ServerConfig.sharedInstance.quotePort)
        case .ENUM_TRADESERVER:
            return String(ServerConfig.sharedInstance.tradePort)
        }
    }
    
    //MARK: DataManagerDelegate
    
}
