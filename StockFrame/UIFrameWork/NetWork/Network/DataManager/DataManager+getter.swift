//
//  DataManager+getter.swift
//  StockFrame
//
//  Created by fdt on 2018/7/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

extension DataManager {
    func getQuoteItem(symbolId: String) -> JQuoteItem? {
        var quoteItem: JQuoteItem?
        queue.sync {
            quoteItem = self.quoteListDic[symbolId];
        }
        return quoteItem
    }
    
    func getChartItem(symbolId: String, period: EnumChartPeriod) -> [ChartLineItem]? {
        var chartItems: [ChartLineItem]?
        queue.sync {
            if let symbolItem = self.chartListDic[symbolId] {
                if let periodItem = symbolItem[String(period.rawValue)] {
                    chartItems = periodItem
                }
            }
        }
        return chartItems
    }
}
