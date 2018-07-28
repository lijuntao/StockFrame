//
//  JQuoteItem.h
//  MasterDataManager
//
//  Created by Rick on 2014/5/19.
//  Copyright (c) 2014年 FDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDefinition.h"
#import  "QuoteFieldItem.h"

@interface JQuoteItem : NSObject <NSCopying,NSCoding>

@property (nonatomic, strong) NSString *symbolID;
@property (assign, readonly) BOOL supportRealTimeQuote;         // 收盤註記

@property (nonatomic, assign) EnumQuoteStale stale;         // 收盤註記
@property (nonatomic, assign) EnumQuoteStatus status;       // 停牌註記
@property (nonatomic, strong) QuoteFieldItem *tradingDate;  // 交易日期
@property (nonatomic, strong) QuoteFieldItem *tradingTime;  // 交易時間

@property (nonatomic, strong) QuoteFieldItem *volume;       // 成交量
@property (nonatomic, strong) QuoteFieldItem *totalVolume;  // 總量

@property (nonatomic, strong) QuoteFieldItem *preClose;     // 昨收
@property (nonatomic, strong) QuoteFieldItem *bid;          // 買進
@property (nonatomic, strong) QuoteFieldItem *ask;          // 賣出
@property (nonatomic, strong) QuoteFieldItem *bidVolume;          // 買進量
@property (nonatomic, strong) QuoteFieldItem *askVolume;          // 賣出量
@property (nonatomic, strong) QuoteFieldItem *price;        // 成交
@property (nonatomic, strong) QuoteFieldItem *priceorPreClose;        // 成交or昨收
@property (nonatomic, strong) QuoteFieldItem *priceChange;  // 漲跌
@property (nonatomic, strong) QuoteFieldItem *priceChangeRatio;  // 漲跌幅

@property (nonatomic, strong) QuoteFieldItem *EN_Name;         // 商品英文名稱
@property (nonatomic, strong) QuoteFieldItem *CN_Name;         // 商品簡中名稱
@property (nonatomic, strong) QuoteFieldItem *TW_Name;         // 商品繁中名稱
@property (nonatomic, strong) QuoteFieldItem *shortName;       //简短名称

@property (nonatomic, strong) QuoteFieldItem *open;         // 開盤價
@property (nonatomic, strong) QuoteFieldItem *high;         // 最高價
@property (nonatomic, strong) QuoteFieldItem *low;          // 最低價
@property (nonatomic, strong) QuoteFieldItem *settlePrice;  // 今日結算價
@property (nonatomic, strong) QuoteFieldItem *openInterest; // 未平倉(持倉)
@property (nonatomic, strong) QuoteFieldItem *close;        // 收盤價
@property (nonatomic, strong) QuoteFieldItem *upLimit;      // 漲停價
@property (nonatomic, strong) QuoteFieldItem *downLimit;    // 跌停價

@property (nonatomic, strong) QuoteFieldItem *high52W;      // 52周最高價
@property (nonatomic, strong) QuoteFieldItem *low52W;       // 52周最低價

@property (nonatomic, strong) QuoteFieldItem *amount;       // 成交總金額
@property (nonatomic, strong) QuoteFieldItem *avgPx;        // 均價
@property (nonatomic, strong) QuoteFieldItem *buyDealVol;   // 內盤量
@property (nonatomic, strong) QuoteFieldItem *sellDealVol;  // 外盤量

@property (nonatomic, strong) QuoteFieldItem *sharesOut;    // 流通股數
@property (nonatomic, strong) QuoteFieldItem *neutralDealVol;  // 不定盤量
@property (nonatomic, strong) QuoteFieldItem *buyDealAmt;   // 內盤金額
@property (nonatomic, strong) QuoteFieldItem *sellDealAmt;  // 外盤金額
@property (nonatomic, strong) QuoteFieldItem *neutralDealAmt;   // 不定盤金額
@property (nonatomic, strong) QuoteFieldItem *totalCapital; // 總股數
@property (nonatomic, strong) QuoteFieldItem *netProfitMgn; // 淨利率
@property (nonatomic, strong) QuoteFieldItem *turnoverRt;   // 換手率
@property (nonatomic, strong) QuoteFieldItem *valPftRt;     // 市盈率
@property (nonatomic, strong) QuoteFieldItem *totalValue;   // 總市值
@property (nonatomic, strong) QuoteFieldItem *outValue;     // 流通市值
@property (nonatomic, strong) QuoteFieldItem *amplitude;    // 振幅
@property (nonatomic, strong) QuoteFieldItem *dividendAmount;       // 股息額
@property (nonatomic, strong) QuoteFieldItem *dividendRate;         // 股息額
@property (nonatomic, strong) QuoteFieldItem *beta;                 // 股息額
@property (nonatomic, strong) QuoteFieldItem *totalAssets;          // 總資產
@property (nonatomic, strong) QuoteFieldItem *nav;                  // 基金淨值
@property (nonatomic, strong) QuoteFieldItem *premiumDiscountRate;  // 溢價率
@property (nonatomic, strong) QuoteFieldItem *ytdReturn;            // 今年回報
@property (nonatomic, strong) QuoteFieldItem *expenseRatio;         // 開支比例

@property (nonatomic, strong) QuoteFieldItem *bidPx1;       // 委買價1
@property (nonatomic, strong) QuoteFieldItem *bidPx2;       // 委買價2
@property (nonatomic, strong) QuoteFieldItem *bidPx3;       // 委買價3
@property (nonatomic, strong) QuoteFieldItem *bidPx4;       // 委買價4
@property (nonatomic, strong) QuoteFieldItem *bidPx5;       // 委買價5

@property (nonatomic, strong) QuoteFieldItem *askPx1;       // 委賣價1
@property (nonatomic, strong) QuoteFieldItem *askPx2;       // 委賣價2
@property (nonatomic, strong) QuoteFieldItem *askPx3;       // 委賣價3
@property (nonatomic, strong) QuoteFieldItem *askPx4;       // 委賣價4
@property (nonatomic, strong) QuoteFieldItem *askPx5;       // 委賣價5

@property (nonatomic, strong) QuoteFieldItem *bidSz1;       // 委買量1 手數(已除以LotSize)
@property (nonatomic, strong) QuoteFieldItem *bidSz2;       // 委買量2
@property (nonatomic, strong) QuoteFieldItem *bidSz3;       // 委買量3
@property (nonatomic, strong) QuoteFieldItem *bidSz4;       // 委買量4
@property (nonatomic, strong) QuoteFieldItem *bidSz5;       // 委買量5

@property (nonatomic, strong) QuoteFieldItem *askSz1;       // 委賣量1 手數(已除以LotSize)
@property (nonatomic, strong) QuoteFieldItem *askSz2;       // 委賣量2
@property (nonatomic, strong) QuoteFieldItem *askSz3;       // 委賣量3
@property (nonatomic, strong) QuoteFieldItem *askSz4;       // 委賣量4
@property (nonatomic, strong) QuoteFieldItem *askSz5;       // 委賣量5
//融资融券字段
@property (nonatomic, strong) QuoteFieldItem *hasRzrq;      //是否为融资融券股票
//牛熊涡轮相关字段
@property (nonatomic, strong) QuoteFieldItem *derivative;    //是否有对应的港股衍生物,1有,0没有
@property (nonatomic, strong) QuoteFieldItem *underlyingSymbol; //正股Symbol
@property (nonatomic, strong) QuoteFieldItem *leverageRatio; //杠杆比例
@property (nonatomic, strong) QuoteFieldItem *exercisePrice; //行使价
@property (nonatomic, strong) QuoteFieldItem *delta; //对冲值
@property (nonatomic, strong) QuoteFieldItem *outstandingQuantityRate; //街货比
@property (nonatomic, strong) QuoteFieldItem *premium; //溢价
@property (nonatomic, strong) QuoteFieldItem *conversionRatio; //换股比例
@property (nonatomic, strong) QuoteFieldItem *impliedVolatility; //引伸波幅
@property (nonatomic, strong) QuoteFieldItem *effectiveLever; //有效杠杆
@property (nonatomic, strong) QuoteFieldItem *strikePoint; //打和点
@property (nonatomic, strong) QuoteFieldItem *maturity; //到期日
@property (nonatomic, strong) QuoteFieldItem *recoverableValue; //回收价
@property (nonatomic, strong) QuoteFieldItem *hkType; //普通股票1，窝轮2，牛熊3
@property (nonatomic, strong) QuoteFieldItem *lastTradeDay; //最后交易日

- (id)initWithSymbolID:(NSString *)strSymbolID;

@end
