//
//  NodeManager.swift
//  StockFrame
//
//  Created by fdt on 2018/6/22.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

let NodeID = "id"
let NodeName = "name"
let NodeType = "type"
let NodeLinkId = "linkid"
let NodePick = "pic"
let NodePageList = "pagelist"
let NodeVCName = "vcName"


class NodeManager {
    static let sharedInstance = NodeManager.init()
    
    var rootElement: GDataXMLElement?
    
    //lift circle
    init() {
        //保存node节点数据
        rootElement = NodeManager.getNodeConfig()
    }
    //读取节点配置文件
    static func getNodeConfig() -> GDataXMLElement? {
        if let filePath = Bundle.main.path(forResource: "FrameConfig", ofType: "xml") {
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
    
    //读取menu Tabbar节点
    func getTabbarMenu() -> [NodeItem] {
        guard let root = rootElement else {
            return []
        }
        // 正常情况下menu 菜单只有一个
        let elements = root.elements(forName: "menu") as! [GDataXMLElement]
        var nodeItems = [NodeItem]()
        for element in elements {
            if element.attribute(forName: "name").stringValue() == "Tabbar" {
                let items = element.elements(forName: "i") as! [GDataXMLElement]
                for item in items {
                    let nodeItem = NodeItem.init()
                    nodeItem.id = item.attribute(forName: NodeID).stringValue()
                    nodeItem.type = item.attribute(forName: NodeType).stringValue()
                    nodeItem.linkid = item.attribute(forName: NodeLinkId).stringValue()
                    nodeItem.pic = item.attribute(forName: NodePick).stringValue()
                    nodeItem.pagelist = item.attribute(forName: NodeLinkId).stringValue()
                    nodeItem.value = item.stringValue()
                    nodeItem.vcName = item.attribute(forName: NodeVCName).stringValue()
                    nodeItems.append(nodeItem)
                }
            }
        }
        return nodeItems
    }
}
