//
//  DataManager+Extension.swift
//  StockFrame
//
//  Created by fdt on 2018/7/17.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

extension DataManager {
    
    
    /// 获取榜单
    ///
    /// - Parameters:
    ///   - market: 市场
    ///   - categories: 参数数组
    func doGetQuoteAndRank(_ type:String, categories:[WmRankingCategoryItem]) {
        self.quoteDataHelper.doWmGetQuoteAndRank(withType: type, categories: categories)
    }
    
    
    /// 订阅quote
    ///
    /// - Parameters:
    ///   - symbolID: 产品数组
    ///   - fs: fieldset ID
    ///   - ch: channel
    func doQuoteRef(_ symbolId: [String], fs: Int = 1,ch: Int = 1) {
        self.quoteDataHelper.doQuoteRef(symbolId, fs: fs, ch: ch)
    }
    
    /// 解订阅quote
    ///
    /// - Parameters:
    ///   - symbolID: 产品数组
    ///   - fs: fieldset ID 默认值为1
    ///   - ch: channel
    func doQuoteUnRef(_ symbolId: [String], fs: Int = 1,ch: Int = 1) {
        self.quoteDataHelper.doQuoteUnRef(symbolId, fs: fs, ch: ch)
    }
    
    func doGetQuote(_ symbolId:[String]) {
        self.quoteDataHelper.doGetQuote(symbolId, fields: nil)
    }
    
    /// chart
    func doTickRef(_ symbolId:[String], period: EnumChartPeriod, count: Int = 200) {
        self.quoteDataHelper.doTickRef(symbolId, period: period, count: Int32(count))
    }
    
    func doTickUnRef(_ symbolId:[String], period: EnumChartPeriod) {
        self.quoteDataHelper.doTickUnRef(symbolId, period: period)
    }
    
    func doGetTickData(_ symbolId: [String], period: EnumChartPeriod, count: Int = 200) {
        self.quoteDataHelper.doGetTickData(symbolId, period: period, count: Int32(count))
    }
    
    func doUnGetTickData(_ symbolId: [String], period: EnumChartPeriod) {
        self.quoteDataHelper.doUnGetTickData(symbolId, period: period)
    }
}
