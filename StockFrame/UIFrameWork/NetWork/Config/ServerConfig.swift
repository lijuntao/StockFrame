//
//  ServerConfig.swift
//  StockFrame
//
//  Created by fdt on 2018/7/6.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class ServerConfig {
    static let sharedInstance = ServerConfig.init()
    
    var loginIP: String!
    var loginPort: Int!
    
    var quoteIP: String!
    var quotePort: Int!
    
    var tradeIP: String!
    var tradePort: Int!
    
    init() {
        loginIP = ""
        loginPort = 0
        
        quoteIP = ""
        quotePort = 0
        
        tradeIP = ""
        tradePort = 0
        
    }
    
    func updateConfig(_ env: String) {
        
        loginIP = ServerManager.sharedInstance.getConfigInfo(env, serverType: .ENUM_LOGINSERVER).ip
        loginPort = ServerManager.sharedInstance.getConfigInfo(env, serverType: .ENUM_LOGINSERVER).port
        
        quoteIP = ServerManager.sharedInstance.getConfigInfo(env, serverType: .ENUM_QUOTESERVER).ip
        quotePort = ServerManager.sharedInstance.getConfigInfo(env, serverType: .ENUM_QUOTESERVER).port
        
        tradeIP = ServerManager.sharedInstance.getConfigInfo(env, serverType: .ENUM_TRADESERVER).ip
        tradePort = ServerManager.sharedInstance.getConfigInfo(env, serverType: .ENUM_TRADESERVER).port
    }
}
