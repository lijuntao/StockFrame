//
//  ServerManager.swift
//  StockFrame
//
//  Created by fdt on 2018/7/6.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

class ServerManager {
    static let sharedInstance = ServerManager.init()
    
    var rootElement: GDataXMLElement?
    
    //lift circle
    init() {
        //保存node节点数据
        rootElement = ServerManager.getNodeConfig()
    }
    //读取节点配置文件
    static func getNodeConfig() -> GDataXMLElement? {
        if let filePath = Bundle.main.path(forResource: "ServerConfig", ofType: "xml") {
            do {
                let xmlData = try Data.init(contentsOf: URL.init(fileURLWithPath: filePath))
                let doc = try GDataXMLDocument.init(data: xmlData, options: 0)
                let root = doc.rootElement().copy()
                return root as? GDataXMLElement
            } catch  {
                assert(false,"解析配置文件失败")
                return nil
            }
        } else {
            assert(false,"解析配置文件失败")
            return nil
        }
    }
    
    
    /// 读取节点
    ///
    /// - Returns: 节点列表
    func getConfigInfo(_ env: String, serverType: ServerType) -> (ip:String,port:Int) {
        var ip = ""
        var port = 0
        guard let root = rootElement else {
            return (ip,port)
        }
        var type = "login"
        switch serverType {
        case .ENUM_LOGINSERVER:
            type = "login"
            break
        case .ENUM_QUOTESERVER:
            type = "quote"
            break
        case .ENUM_TRADESERVER:
            type = "trade"
            break
        }
        
        let elements = root.elements(forName: "menu") as! [GDataXMLElement]
        for element in elements {
            if element.attribute(forName: "type").stringValue() == env {
                let items = element.elements(forName: "i") as! [GDataXMLElement]
                for item in items {
                    if item.stringValue() == type {
                        ip = item.attribute(forName: "ip").stringValue()
                        port = item.attribute(forName: "port").stringValue().integer
                    }
                }
            }
        }
        return (ip,port)
    }
}
