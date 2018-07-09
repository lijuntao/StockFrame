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
let NodeStackLevel = "stackLevel"
let NodeVCName = "vcname"
let NodeList = "list"


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
    
    
    /// 读取menu Tabbar节点
    ///
    /// - Returns: 节点列表
    func getTabbarMenu() -> [NodeItem] {
        guard let root = rootElement else {
            return []
        }
        // 正常情况下menu 菜单id == 1000 即为tabbar配置
        let elements = root.elements(forName: "menu") as! [GDataXMLElement]
        var nodeItems = [NodeItem]()
        for element in elements {
            if element.attribute(forName: "id").stringValue() == "100" {
                let items = element.elements(forName: "i") as! [GDataXMLElement]
                for item in items {
                    let nodeItem = NodeItem.init()
                    nodeItem.id = item.attribute(forName: NodeID).stringValue().integer
                    nodeItem.type = item.attribute(forName: NodeType).stringValue()
                    nodeItem.linkid = item.attribute(forName: NodeLinkId).stringValue().integer
                    nodeItem.pic = item.attribute(forName: NodePick).stringValue()
                    nodeItem.pagelist = item.attribute(forName: NodePageList).stringValue().integer
                    nodeItem.name = item.attribute(forName: NodeName).stringValue()
                    nodeItems.append(nodeItem)
                }
            }
        }
        return nodeItems
    }
    
    
    /// 获取弹出竖屏
    ///
    /// - Returns: 节点数组
    func getPopPortraitMenu() -> [NodeItem] {
        guard let root = rootElement else {
            return []
        }
        // 正常情况下menu 菜单id == 1000 即为tabbar配置
        let elements = root.elements(forName: "menu") as! [GDataXMLElement]
        var nodeItems = [NodeItem]()
        for element in elements {
            if element.attribute(forName: "id").stringValue() == "102" {
                let items = element.elements(forName: "i") as! [GDataXMLElement]
                for item in items {
                    let nodeItem = NodeItem.init()
                    nodeItem.id = item.attribute(forName: NodeID).stringValue().integer
                    nodeItem.type = item.attribute(forName: NodeType).stringValue()
                    nodeItem.linkid = item.attribute(forName: NodeLinkId).stringValue().integer
                    nodeItem.pagelist = item.attribute(forName: NodePageList).stringValue().integer
                    nodeItem.name = item.attribute(forName: NodeName).stringValue()
                    nodeItems.append(nodeItem)
                }
            }
        }
        return nodeItems
    }
    /// 根据Id获取node信息
    ///
    /// - Parameter id: id
    /// - Returns: NodeItem
    func getNodeItemWithId(_ id: Int) -> NodeItem {
        guard let root = rootElement else {
            return NodeItem()
        }
        let nodeItem = NodeItem()
        let elements = root.elements(forName: "page") as! [GDataXMLElement]
        for element in elements {
            if element.attribute(forName: NodeID).stringValue().integer == id {
                nodeItem.id = element.attribute(forName: NodeID).stringValue().integer
                nodeItem.type = element.attribute(forName: NodeType).stringValue()
                nodeItem.name = element.attribute(forName: NodeName).stringValue()
                nodeItem.stackLevel = element.attribute(forName: NodeStackLevel).stringValue().integer
                nodeItem.vcName = element.attribute(forName: NodeVCName).stringValue()
                break
            }
        }
        return nodeItem
    }
    
    /// pagelist 在tabbar中的索引
    ///
    /// - Parameter pageList: pagelist
    /// - Returns: index
    func getTabBarPageIndex(_ pageList: Int) -> Int {
        guard let root = rootElement else {
            return -1
        }
        let elements = root.elements(forName: "menu") as! [GDataXMLElement]
        var pageListIndex = 0
        for element in elements {
            if element.attribute(forName: "id").stringValue() == "100" {
                let items = element.elements(forName: "i") as! [GDataXMLElement]
                for (index, item) in items.enumerated() {
                    let nodePageList = item.attribute(forName: NodePageList).stringValue().integer
                    if nodePageList == pageList {
                        pageListIndex = index
                        break
                    }
                }
            }
        }
        return pageListIndex
    }
    
    
    /// 当前栈中是否支持此id
    ///
    /// - Parameters:
    ///   - id: id
    ///   - pageList: 导航栈pageList
    /// - Returns: true 支持 false 不支持
    func pageIsInPageList(_ id: Int, pageList: Int) -> Bool {
        guard let root = rootElement else {
            return false
        }
        let elements = root.elements(forName: "menu") as! [GDataXMLElement]
        var list = ""
        for element in elements {
            if element.attribute(forName: "id").stringValue() == "101" {
                let items = element.elements(forName: "i") as! [GDataXMLElement]
                for (_, item) in items.enumerated() {
                    let nodePageList = item.attribute(forName: NodePageList).stringValue().integer
                    if nodePageList == pageList {
                        list = item.attribute(forName: NodeList).stringValue()
                        break
                    }
                }
            }
        }
        return self.pageIsInList(id, list: list)
    }
    
    
    /// 当前栈中是否支持此id
    /// 具体判断list 2701-2713,2788 含有-代表区间
    /// - Parameters:
    ///   - id: id
    ///   - list: pagelist栈所支持的pageid字符串
    /// - Returns: true 支持 false 不支持
    func pageIsInList(_ id: Int, list: String) -> Bool {
        let listArray = list.components(separatedBy: ",")
        var isIn = false
        for item in listArray {
            if item.contains("-") {
                let subListArray = item.components(separatedBy: "-")
                let start = subListArray.first?.integer ?? 0
                let end = subListArray.last?.integer ?? 0
                if id >= start && id <= end {
                    isIn = true
                    break
                }
            } else {
                if id == item.integer {
                    isIn = true
                    break
                }
            }
        }

        return isIn
    }
    
    
    /// 根据tabbar selected判断当前的栈的pageList
    ///
    /// - Parameter selected: 索引
    /// - Returns: pageList
    func pageListWithSelected(_ selected: Int) -> Int {
        guard let root = rootElement else {
            return -1
        }
        let elements = root.elements(forName: "menu") as! [GDataXMLElement]
        var pageList = -1
        for element in elements {
            if element.attribute(forName: "id").stringValue() == "100" {
                let items = element.elements(forName: "i") as! [GDataXMLElement]
                for (index, item) in items.enumerated() {
                    if index == selected {
                        pageList = item.attribute(forName: NodePageList).stringValue().integer
                        break
                    }
                }
            }
        }
        
        return pageList
    }
    
    
    /// 根据id获取当前id属于是那个Nav导航栈
    /// 先判断当前导航栈是否包含此id 有则返回当前栈index 否则 遍历所有导航栈直到找到为止,返回匹配栈的index
    /// 如果没找到则返回-1
    /// - Parameters:
    ///   - id: id
    ///   - curSelected: 当前选择索引
    /// - Returns: id所在栈的索引
    func getTabBarItemIndex(_ id: Int, curSelected: Int) -> Int {
        var stackIndex = curSelected
        
        //当前的栈 pageList
        let curPageList = self.pageListWithSelected(curSelected)
        
        //判断当前栈
        if self.pageIsInPageList(id, pageList: curPageList) {
            return stackIndex
        }
        
        guard let root = rootElement else {
            return stackIndex
        }
        //寻找合适的栈
        let elements = root.elements(forName: "menu") as! [GDataXMLElement]
        for element in elements {
            if element.attribute(forName: "id").stringValue() == "101" {
                let items = element.elements(forName: "i") as! [GDataXMLElement]
                for (_, item) in items.enumerated() {
                    let list = item.attribute(forName: NodeList).stringValue()!
                    if self.pageIsInList(id, list: list) {
                        let pageList = item.attribute(forName: NodePageList).stringValue().integer
                        stackIndex = self.getTabBarPageIndex(pageList)
                        break
                    }
                }
            }
        }
        return stackIndex
    }
    
    /// 是否为弹出视图
    ///
    /// - Parameter node: 节点 NodeItem
    /// - Returns: true 是 false 不是
    func isPopPortraitNode(_ node: NodeItem) -> Bool {
        if let pageList = self.getPopPortraitMenu().first?.pagelist {
            //判断
            if self.pageIsInPageList(node.id, pageList: pageList) {
                return true
            }
        }
        return false
    }
}
