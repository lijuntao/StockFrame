//
//  DataManger+QuoteUpdate.swift
//  StockFrame
//
//  Created by fdt on 2018/7/17.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

extension DataManager {
    
    
    /// 保存 MarketStatus 状态
    ///
    /// - Parameter packet: 接收数据包
    func handleMarketStatus(_ packet:JPacketReceiveBase) {
        let pkt = packet as! MarketStatusUpdate
        queue.async(flags: .barrier) {
            var dic:[String:Int] = [:]
            if self.marketStatueDic.keys.contains(pkt.ex) {
                dic = self.marketStatueDic[pkt.ex]!
            }
            dic[pkt.sesname] = pkt.status
            self.marketStatueDic[pkt.ex] = dic
        }
    }
    
    
    /// 榜单返回处理
    ///
    /// - Parameter packet: 数据包
    func handleWmQuoteAndRankUpdate(_ packet:JPacketReceiveBase) {
        let pkt = packet as! WmQuoteAndRankUpdate
        let item = WmQuoteGroupRankingItem.init()
        item.type = pkt.type
        for categoryCore in pkt.categories! {
            if categoryCore.data?.count == 0 {
                let empty = WmGroupCategoryBaseItem.init()
                empty.isEmpty = true
                item.addIndustryOrSymbol(empty, category: categoryCore.id, level: categoryCore.level)
            } else {
                var language = "CN"
                switch FDTOCTools.getDeviceLanguage() {
                case .CN:
                    language = "CN"
                case .TW:
                    language = "TW"
                case .EN:
                    language = "EN"
                }
                
                let category = RankingCategory(rawValue: categoryCore.id)!
                switch category {
                case .Industry:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategoryIndustryItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                case .MainAMT:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategorySymbolItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                case .Amt:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategoryAmountItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                case .Forex, .Cny:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategoryForexItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                case .AH:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategoryAHStockItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                case .Turnover:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategoryTurnoverItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                default:
                    for dataCore in categoryCore.data! {
                        let symbolItem = WmGroupCategorySymbolItem.init()
                        symbolItem.fillData(dataCore, withLanguage: language)
                        item.addIndustryOrSymbol(symbolItem, category: categoryCore.id, level: categoryCore.level)
                    }
                }
            }    
        }
        self.postDelegate.postNotification(withType: .OBSERVER_UPDATE_QUOTE_AND_RANK, object: item)
    }
}
