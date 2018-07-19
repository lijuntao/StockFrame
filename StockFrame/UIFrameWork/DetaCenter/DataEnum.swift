//
//  DataEnum.swift
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation


/// 排序方式
///
enum FDTSortType: Int{
    case none
    case descending
    case ascending
}

/// 榜单类型
///
/// - case: 类别
enum RankingCategory: String {
    case SH = "SH"
    case Amt = "AMT"
    case Down = "DOWN"
}

