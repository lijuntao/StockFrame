//
//  DataCenter+getter.swift
//  StockFrame
//
//  Created by fdt on 2018/7/27.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

extension DataCenter {
    
    func getSymbolMarketString(symbolId: String) -> String {
        let arr = symbolId.components(separatedBy: ".")
        if arr.count > 3 {
            return arr[2] //"XXXXX.XXX.US.WM" //美股
        } else if arr.count >= 2 {
            return arr[1] // "000001.SZ.WM"
        }
        return ""
    }
    
    func getSymboMarketType(symbolId: String) -> MarketType {
        let marketString = self.getSymbolMarketString(symbolId: symbolId)
        if let marketType = MarketType(rawValue: marketString) {
            return marketType
        }
        return .SH
    }
    
    func getQuoteItem(symbolId: String) -> JQuoteItem? {
        return self.dataManager.getQuoteItem(symbolId: symbolId)
    }
    
    func getChartItem(symbolId: String, period: EnumChartPeriod) -> [ChartLineItem]? {
        return self.dataManager.getChartItem(symbolId: symbolId, period: period)
    }
}
