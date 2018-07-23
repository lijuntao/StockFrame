//
//  StockRankCellViewModel.swift
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class StockRankCellViewModel: BaseViewModel {

    var symbolName: String! //股票名称
    var symbolName2: String! //股票代码
    var symbolMarket: String! //股票市场
    
    var symbolMarketColor: UIColor!  //市场图标颜色
    var symbolMarketBGColor: UIColor! //市场图标背景颜色
    
    var last: String! //最新价
    var chg: String!  //涨跌
    var chgP: String! //涨跌幅
    var chgAttr: NSAttributedString! // 涨跌 外汇
    var lastAttr: NSAttributedString! //最新价 外汇
    var totalValue: NSAttributedString! //成交额

    var lastColor: UIColor! //最新价颜色
    var changeColor: UIColor! //涨跌颜色
    
    var stale: EnumQuoteStale = .none //停盘标记
    
    
    var item: WmGroupCategoryBaseItem!
    
    func setDataItem(_ item: WmGroupCategoryBaseItem)
    {
        self.item = item
        
        symbolName = item.name
        symbolName2 = FDTTools.getSymbolShortId(item.id)
        symbolMarket = FDTTools.getMarketWithSymbolId(item.id)
        
        symbolMarketColor = FDTWMColor.backgroundColor.color
        symbolMarketBGColor = CurrencyType.getType(symbolMarket).marketColor
        
        stale = item.stale
        
        if item is WmGroupCategorySymbolItem {
            let data = item as! WmGroupCategorySymbolItem
            
            if let formatPrice = data.formatPrice {
                last = formatPrice
            } else {
                last = FDTFormatterUtility.convetToString(data.price)
            }
            self.lastColor = self.getLastColor(data.price)
            
            chgP = FDTFormatterUtility.convetToString(data.chgpct)
            if chgP != Constant.string.invalid
            {
                chgP = FDTFormatterUtility.formatToDecimalStyle(data.chgpct, maximumFractionDigits: 2, minimumFractionDigits: 2, roundingMode: NumberFormatter.RoundingMode.down) + "%"
            }
            self.changeColor = FDTTools.getRiseOrFallColor(data.chgpct)
        }
        else if item is WmGroupCategoryAmountItem {
            let data = item as! WmGroupCategoryAmountItem
            
            if let formatPrice = data.formatPrice {
                last = formatPrice
            } else {
                last = FDTFormatterUtility.convetToString(data.price)
            }
            self.lastColor = self.getLastColor(data.price)
            self.changeColor = FDTWMColor.defalueTextColor.color
            
            self.changeColor = FDTTools.getRiseOrFallColor(data.sym_ratio)
            
            var totalValueStr = FDTFormatterUtility.convetToString(data.amount)
            if totalValueStr != Constant.string.invalid
            {
                totalValueStr = FDTFormatterUtility.formatToReadableStyle(data.amount!, withComma: true)
                totalValue = FDTWMUiUtility.atributeString(totalValueStr, leftFont: UIFont.dinRegularFontOfSize(22), leftRange: NSMakeRange(0, totalValueStr.length - 1), rightFont: UIFont.pingFangSCRegularFontOfSize(22), rightRange: NSMakeRange(totalValueStr.length - 1, 1))
            }
        }
        else if item is WmGroupCategoryForexItem {
            let data = item as! WmGroupCategoryForexItem
            
            if let formatPrice = data.formatPrice {
                last = formatPrice
                lastAttr = FDTWMUiUtility.attributeStringWtihWMFXStyle(formatPrice, font: UIFont.dinRegularFontOfSize(22))
            } else {
                last = FDTFormatterUtility.convetToString(data.price)
                lastAttr = FDTWMUiUtility.attributeStringWtihWMFXStyle(last, font: UIFont.dinRegularFontOfSize(22))
            }
            self.lastColor = self.getLastColor(data.price)
            
            chg = FDTFormatterUtility.convetToString(data.chg)
            if chg != Constant.string.invalid
            {
                chg = data.formatChg
                chgAttr = FDTWMUiUtility.attributeStringWtihWMFXStyle(chg, font: UIFont.dinRegularFontOfSize(22))
            }
            self.changeColor = FDTTools.getRiseOrFallColor(data.chg)
        }
    }
    
    func getLastColor(_ price: NSNumber!) -> UIColor {
        if stale == .invalid {
            return FDTWMColor.marketCloseColor.color
        } else {
            return FDTTools.getRiseOrFallColor(price)
        }
    }
    
    func isAmtItem() -> Bool {
        return self.item is WmGroupCategoryAmountItem
    }
    
    func isFXItem() -> Bool {
        return self.item is WmGroupCategoryForexItem
    }
}
