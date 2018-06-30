//
//  NodeItem.swift
//  StockFrame
//
//  Created by fdt on 2018/6/15.
//  Copyright © 2018年 ljt. All rights reserved.
//


import UIKit

/// 节点类
class NodeItem {
    var id: Int
    var name: String
    var type: String
    var pic: String
    var linkid: Int
    var pagelist: Int
    var stackLevel: Int
    var value: String
    var vcName: String
    var list: String
    init() {
        id = 0
        name = ""
        type = ""
        pic = ""
        linkid = 0
        pagelist = 0
        stackLevel = 0
        value = ""
        vcName = ""
        list = ""
    }
}
