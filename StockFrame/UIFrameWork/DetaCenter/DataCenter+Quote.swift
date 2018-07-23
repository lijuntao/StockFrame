//
//  DataCenter+Quote.swift
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

extension DataCenter {
    
    /// 获取榜单
    ///
    /// - Parameters:
    ///   - market: 市场
    ///   - categories: 参数数组
    func doGetQuoteAndRank(_ market:String, categories:[(category: RankingCategory,sort: FDTSortType)]?, level: Int = 0)
    {
        var categoriesArray:Array<WmRankingCategoryItem> = Array<WmRankingCategoryItem>()
        if let array = categories
        {
            for category in array {
                
                let item = WmRankingCategoryItem.init(category: category.category.rawValue, level: level, desc: (category.sort == FDTSortType.descending ? 0 : 1))
                categoriesArray.append(item)
            }
        }
        self.dataManager.doGetQuoteAndRank(market, categories: categoriesArray)
    }
    
    func doQuoteRef(_ symbolId: [String]) {
        self.dataManager.doQuoteRef(symbolId)
    }
    
    func doQuoteUnRef(_ symbolId: [String]) {
        self.dataManager.doQuoteUnRef(symbolId)
    }
    
    func doGetQuote(_ symbolId: [String]) {
        self.dataManager.doGetQuote(symbolId)
    }
}
