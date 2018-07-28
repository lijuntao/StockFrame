//
//  StockRankAHCellViewModel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/22.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockRankAHCellViewModel: BaseViewModel {

    var symbolID: String! // 股票symbol
    var symbolName: String! //股票名称
    var symbolName2: String! //股票代码
    var symbolMarket: String! //股票市场
    var symbolMarketColor: UIColor!  //市场图标颜色
    var symbolMarketBGColor: UIColor! //市场图标背景颜色
    
    var hLastPrice: String!  //H股最新价
    var hLastRatio: String!  //H股涨跌幅
    var hLastColor: UIColor! //H股字体颜色
    
    var aLastPrice: String!  //A股最新价
    var aLastRatio: String!  //A股涨跌幅
    var aLastColor: UIColor! //A股字体颜色
    
    var premium: String! //溢价
    var premiumColor: UIColor! //溢价
    
    var stale: EnumQuoteStale = .none //停盘标记
    
    var item: WmGroupCategoryBaseItem!
    
    func setDataItem(_ item: WmGroupCategoryBaseItem)
    {
        self.item = item
        symbolID = item.id
        symbolName = item.name
        symbolName2 = FDTTools.getSymbolShortId(item.id)
        symbolMarket = FDTTools.getMarketWithSymbolId(item.id)
        
        symbolMarketColor = FDTWMColor.backgroundColor.color
        symbolMarketBGColor = CurrencyType.getType(symbolMarket).marketColor
        
        stale = item.stale
        
        if item is WmGroupCategoryAHStockItem {
            let data = item as! WmGroupCategoryAHStockItem
            
            if let formatPrice = data.sym_price_str {
                hLastPrice = formatPrice
            } else {
                hLastPrice = FDTFormatterUtility.convetToString(data.sym_price)
            }
            hLastRatio = FDTFormatterUtility.convetToString(data.sym_ratio)
            if hLastRatio != Constant.string.invalid
            {
                hLastRatio = FDTFormatterUtility.formatToDecimalStyle(data.sym_ratio, maximumFractionDigits: 2, minimumFractionDigits: 2, roundingMode: NumberFormatter.RoundingMode.down) + "%"
            }
            if let ratio = data.sym_ratio {
                hLastColor = self.getLastColor(ratio)
            } else {
                hLastColor = UIColor.init(wmColor: FDTWMColor.unchangeColor)
            }
            
            aLastPrice = FDTFormatterUtility.convetToString(data.sym_aprice)
            aLastRatio = FDTFormatterUtility.convetToString(data.sym_aratio)
            if aLastRatio != Constant.string.invalid
            {
                aLastRatio = FDTFormatterUtility.formatToDecimalStyle(data.sym_aratio, maximumFractionDigits: 2, minimumFractionDigits: 2, roundingMode: NumberFormatter.RoundingMode.down) + "%"
            }
            aLastColor = self.getLastColor(data.sym_aratio)
            
            premium = FDTFormatterUtility.convetToString(data.sym_premium?.multiplying(by: NSDecimalNumber.init(value: 100)))  //百分比显示，需要乘以100
            if premium != Constant.string.invalid
            {
                premium = FDTFormatterUtility.formatToDecimalStyle(data.sym_premium?.multiplying(by: NSDecimalNumber.init(value: 100)), maximumFractionDigits: 2, minimumFractionDigits: 2, roundingMode: NumberFormatter.RoundingMode.down) + "%"
            }
            premiumColor = FDTTools.getRiseOrFallColor(data.sym_premium)
        }
    }
    
    func getLastColor(_ price: NSNumber!) -> UIColor {
        if stale == .invalid {
            return FDTWMColor.marketCloseColor.color
        } else {
            return FDTTools.getRiseOrFallColor(price)
        }
    }
}
