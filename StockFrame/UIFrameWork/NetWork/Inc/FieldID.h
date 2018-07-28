//
//  FieldID.h
//  StockFrame
//
//  Created by fdt on 2018/7/23.
//  Copyright © 2018年 ljt. All rights reserved.
//

#ifndef FieldID_h
#define FieldID_h

typedef NS_ENUM(NSUInteger, EnumFieldID)
{
    FID_TotalVolume = 14,   // 總量
    FID_Price = 31,         // 成交
    FID_TradingDate = 75,   // 交易日期
    FID_Bid = 132,          // 買進
    FID_Ask = 133,          // 賣出
    FID_BidVolume = 134,          // 買進量
    FID_AskVolume = 135,          // 賣出量
    FID_PreClose = 140,     // 昨收
    FID_TradingTime = 273,  // 交易時間
    FID_High = 332,         // 最高價
    FID_Low = 333,          // 最低價
    FID_SettlePrice = 730,  // 今日結算價
    FID_OpenInterest = 746, // 未平倉(持倉)
    FID_Volume = 1020,      // 成交量(單量)
    FID_Open = 1025,        // 開盤價
    FID_DownLimit = 1148,   // 跌停價
    FID_UpLimit = 1149,     // 漲停價
    
    FID_52WHigh = 20002,    // 52周最高價
    FID_52WLow  = 20003,    // 52周最低價
    FID_PriceChange  = 20004,    // 漲跌
    FID_PriceChangeRatio  = 20005,    // 漲跌幅
    FID_ShortName   = 20006,    // 商品短名
    FID_EN_Name     = 20007,    // 商品英文名稱
    FID_CN_Name     = 20008,    // 商品簡中名稱
    FID_TW_Name     = 20010,    // 商品繁中名稱
    
    FID_Amount      = 20011,    // TurnOver, 成交總金額
    FID_AvgPx       = 20012,    // 均價
    FID_Status      = 20013,    // 狀態
    FID_BuyDealVol  = 20014,    // 內盤量
    FID_SellDealVol = 20015,    // 外盤量
    FID_DCPreClose  = 20016,    // Base Price for Day Chart
    FID_RStatus     = 20017,    // 準備狀態
    FID_SharesOut   = 20018,    // 流通股數
    FID_NeutralDealVol  =   20019,  // 不定盤量
    FID_BuyDealAmt  = 20020,    // 內盤金額
    FID_SellDealAmt = 20021,    // 外盤金額
    FID_NeutralDealAmt = 20022, // 不定盤金額
    FID_TotalCapital = 20023,   // 總股數
    FID_NetProfitMgn = 20024,   // 淨利率
    FID_TurnoverRt = 20025,     // 換手率
    FID_ValPftRt = 20026,       // 市盈率
    FID_TotalValue = 20027,     // 總市值
    FID_OutValue = 20028,       // 流通市值
    FID_Amplitude = 20029,      // 振幅
    FID_DividendAmount = 20030,         // 股息額
    FID_DividendRate = 20031,           // 股息率
    FID_Beta = 20032,                   // 貝塔係數
    FID_TotalAssets = 20033,            // 總資產
    FID_Nav = 20034,                    // 基金淨值
    FID_PremiumDiscountRate = 20035,    // 溢價率
    FID_YtdReturn = 20036,              // 今年回報
    FID_ExpenseRatio = 20037,           // 開支比例
    
    FID_BidPx1 = 20101, // 委買價1
    FID_AskPx1 = 20102, // 委賣價1
    FID_BidPx2 = 20103, // 委買價2
    FID_AskPx2 = 20104, // 委賣價2
    FID_BidPx3 = 20105, // 委買價3
    FID_AskPx3 = 20106, // 委賣價3
    FID_BidPx4 = 20107, // 委買價4
    FID_AskPx4 = 20108, // 委賣價4
    FID_BidPx5 = 20109, // 委買價5
    FID_AskPx5 = 20110, // 委賣價5
    
    FID_BidSz1 = 20111, // 委買量1
    FID_AskSz1 = 20112, // 委賣量1
    FID_BidSz2 = 20113, // 委買量2
    FID_AskSz2 = 20114, // 委賣量2
    FID_BidSz3 = 20115, // 委買量3
    FID_AskSz3 = 20116, // 委賣量3
    FID_BidSz4 = 20117, // 委買量4
    FID_AskSz4 = 20118, // 委賣量4
    FID_BidSz5 = 20119, // 委買量5
    FID_AskSz5 = 20120, // 委賣量5
    
    FID_RZRQ = 30019, //融资融券
    
    FID_Derivative = 30018, // 是否有对应的港股衍生物,1有,0没有
    FID_Underlying = 30004, // 对应正股symbol
    FID_LeverageRatio = 30005, // 杠杆比例
    FID_ExercisePrice = 30006, // 行使价
    FID_Delta = 30007, // 对冲值
    FID_OutstandingQuantityRate = 30008, // 街货比
    FID_Premium = 30009, // 溢价
    FID_ConversionRatio = 30010, // 换股比例
    FID_ImpliedVolatility = 30011, // 引伸波幅
    FID_EffectiveLever = 30012, // 有效杠杆
    FID_StrikePoint = 30013, // 打和点
    FID_Maturity = 30014, // 到期日
    FID_RecoverableValue = 30015, // 回收价
    FID_HkType = 30016, // 普通股票1，窝轮2，牛熊3
    FID_LastTradeDay = 30017, // 最后交易日
};

#endif /* FieldID_h */
