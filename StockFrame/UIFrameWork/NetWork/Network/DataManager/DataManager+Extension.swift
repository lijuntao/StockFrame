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
}
