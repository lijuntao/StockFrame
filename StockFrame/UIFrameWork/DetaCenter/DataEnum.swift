//
//  DataEnum.swift
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

import Foundation

enum MarketType: String
{
    case SH = "SH"
    case SZ = "SZ"
    case HK = "HK"
    case USD = "US"
    case Globle = "GLOBAL"
    case Portfolio = "PORTFOLIO"
    
    var title: String {
        switch self {
        case .USD:
            return L10n.accountAccounttitleUs.string
        case .HK:
            return L10n.accountAccounttitleHk.string
        case .SH:
            return L10n.accountAccounttitleAshare.string
        case .Globle:
            return L10n.stockMarketGlobalindex.string
        case .Portfolio:
            return L10n.stockPortfolio.string
        case .SZ:
            return "SZ"
        }
    }
}

/// 列表tablecell 类型
enum TableViewCellType {
    case simple
    case normal
    case ah
}

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
    case SH = "SH"  //沪股通涨幅榜
    case Amt = "AMT" //成交额榜
    case Down = "DOWN" //跌幅榜
    case Up = "UP" //深股通涨幅榜
    case MainAMT = "MAINAMT" //主板成交额榜
    case MainUp = "MAINUP" //主板涨幅榜
    case MainDown = "MAINDOWN" //主板跌幅榜
    case AH = "AH"  //AH股
    case ETF = "ETF" //etf
    case China = "CHINA" //中概股
    case Star = "STAR" //明星股
    case Common = "COMMON" //全球 常用
    case Western = "WESTERN" //全球 欧美指数
    case Forex = "FOREX" //全球 外汇
    case Cny = "CNY" //全球 人民币即期
    case Asia = "ASIA" //全球 亚指数
    case Bulk = "BULK"
    case Industry = "INDUSTRY" //热门
    case Turnover = "ASHARESTURNOVER"   //换手率
    
    var cellType: TableViewCellType {
        switch self {
        case .Common, .Western, .Forex, .Cny:
            return .simple
        case .AH:
            return .ah
        default:
            return .normal
        }
    }
    
    static func getRankingCategory(_ category: String) -> RankingCategory? {
        
        switch category {
        case SH.rawValue:
            return SH
        case Down.rawValue:
            return Down
        case Amt.rawValue:
            return Amt
        case Up.rawValue:
            return Up
        case MainUp.rawValue:
            return MainUp
        case MainAMT.rawValue:
            return MainAMT
        case Industry.rawValue:
            return Industry
        case MainDown.rawValue:
            return MainDown
        case AH.rawValue:
            return AH
        case China.rawValue:
            return China
        case Star.rawValue:
            return Star
        case ETF.rawValue:
            return ETF
        case Common.rawValue:
            return Common
        case Western.rawValue:
            return Western
        case Asia.rawValue:
            return Asia
        case Bulk.rawValue:
            return Bulk
        case Forex.rawValue:
            return Forex
        case Cny.rawValue:
            return Cny
        default:
            return nil;
        }
    }
    
    func title(_ market:MarketType)-> String {
        
        switch self {
        case .SH:
            return L10n.stockMarketShMainAdvanced.string    //
        case .Down:
            if(market == .SZ){
                return L10n.stockMarketSzMainActive.string
            }
            return L10n.stockMarketShMainActive.string    //
        case .Amt:
            if(market == .SZ){
                return L10n.stockMarketSzMainMostActive.string
            }
            return L10n.stockMarketShMainMostActive.string    //todo
        case .MainUp:
            return L10n.stockMarketHkMainAdvanced.string
        case .MainAMT:
            return L10n.stockMarketHkMainActive.string
        case .Industry:
            return L10n.stockMarketHotIndustry.string
        case .MainDown:
            return L10n.stockMarketHkMainDeclined.string
        case .AH:
            return L10n.ahStockMain.string
        case .China:
            return L10n.stockMarketUsCn.string
        case .Star:
            return L10n.stockMarketUsStar.string
        case .ETF:
            return "ETF"
        case .Common:
            return L10n.stockMarketGlobalCommon.string
        case .Western:
            return L10n.stockMarketGlobalEu.string
        case .Asia:
            return L10n.stockMarketGlobalAsia.string
        case .Bulk:
            return L10n.stockMarketGlobalFutures.string
        case .Forex:
            return L10n.stockMarketGlobalForex.string
        case .Cny:
            return L10n.stockMarketGlobalCnforex.string
        //todo fix lanuage
        case .Up:
            return L10n.stockMarketSzMainAdvanced.string
        default:
            return ""
        }
    }
}

