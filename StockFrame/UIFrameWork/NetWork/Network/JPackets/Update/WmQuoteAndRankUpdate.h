//
//  WmQuoteAndRankUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/4.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface WmCategoryDataCore : NSObject
/**
 *  行業 ID
 */
@property (nonatomic, strong, nullable) NSString *industry;
/**
 *  行業英文名稱
 */
@property (nonatomic, strong, nullable) NSString *industry_en;
/**
 *  行業簡中名稱
 */
@property (nonatomic, strong, nullable) NSString *industry_cn;
/**
 *  行業繁中名稱
 */
@property (nonatomic, strong, nullable) NSString *industry_tw;
/**
 *  行業漲跌幅
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *industry_ratio;
/**
 *  行業的領漲股或此筆就只有 symbol 沒有行業
 */
@property (nonatomic, strong, nullable) NSString *sym;
/**
 *  Symbol 英文名稱
 */
@property (nonatomic, strong, nullable) NSString *sym_en;
/**
 *  Symbol 繁中名稱
 */
@property (nonatomic, strong, nullable) NSString *sym_cn;
/**
 *  Symbol 繁中名稱
 */
@property (nonatomic, strong, nullable) NSString *sym_tw;
/**
 *  Symbol 漲跌幅
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_ratio;
/**
 *  Symbol 最新價
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_price;
/**
 *  成交額
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *amount;

/**
 *  Symbol short name
 */
@property (nonatomic, strong, nullable) NSString *sym_shortname;

/**
 *  Symbol 漲跌
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_chg;

/**
 *  Symbol 最新價字串格式
 */
@property (nonatomic, strong, nullable) NSString *sym_price_str;

/**
 *  Symbol 商品細類別
 */
@property (nonatomic, strong, nullable) NSString *sym_section;

/**
 *  Optional，表示現在這個商品是否己經過了交易時間，Client在收到此旗標為1時，應將Client的Market Data變成灰色(收盤顏色）。
 */
@property (nonatomic) EnumQuoteStale sym_stale;


/**
 * Symbol 涨跌字符串格式
 */
@property (nonatomic, strong, nullable) NSString *sym_change_str;


/**
 * 1表示是（沪）深股通，0表示不是
 */
@property (nonatomic, assign) NSInteger sym_hk_con;


/**
 * 换手率
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_turnover;


/**
 * A股的symbol（AH榜单专用）
 */
@property (nonatomic, strong, nullable) NSString *sym_ashares;


/**
 * A股的涨跌幅（AH榜单专用）
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_aratio;


/**
 * AH股溢价率，计算规则为
 * 溢价=( H股现价/（A股现价*人民币兑港币的即期汇率）-1)*100%
 * 如:浙江世宝（01057）溢价=( H股现价/（A股现价*人民币兑港币的即期汇率）-1)*100%
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_premium;


/**
 * a股的价格
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_aprice;

@end


@interface WmCategoryCore : NSObject

/**
 *  Category ID
 */
@property (nonnull, nonatomic, strong,readonly) NSString *Id;

/**
 *  此 Category 第幾層資料，從 0 開始
 */

@property (nonatomic, assign,readonly) NSInteger level;
/**
 *  是否倒序
 0: 漲最多先
 1: 跌最多先
 */
@property (nonatomic, assign,readonly) NSInteger desc;
/**
 *  Optional，An array of Item，查詢的分類結果
 */
@property (nullable, nonatomic, strong,readonly) NSArray<WmCategoryDataCore *> *data;

@end


@class WmRankingCategoryItem;
@interface WmQuoteAndRankUpdate : JPacketReceiveBase
/**
 *  SH: 滬股通
    HK: 港股
    US: 美股
    GLOBAL: 全球
 */
@property (nonnull, nonatomic, strong, readonly) NSString *type;
/**
 *  An array of Category，要查詢的分類
 */
@property (nullable, nonatomic, strong, readonly) NSArray<WmCategoryCore *> *categories;
/**
 *  預留以備優化使用
 */
@property (nonatomic, assign, readonly) NSInteger timestamp;
@end
