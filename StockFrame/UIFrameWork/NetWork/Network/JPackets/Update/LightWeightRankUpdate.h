//
//  LightWeightRankUpdate.h
//  MasterDataManager
//
//  Created by ljt on 2017/7/24.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface LightWeightCategoryDataCore : NSObject
/**
 *  行業英文名稱
 */
@property (nonatomic, strong, nullable) NSString *sym_en;
/**
 *  行業簡中名稱
 */
@property (nonatomic, strong, nullable) NSString *sym_cn;
/**
 *  行業繁中名稱
 */
@property (nonatomic, strong, nullable) NSString *sym_tw;

/**
 *  Symbol 代码
 */
@property (nonatomic, strong, nonnull) NSString *sym_code;

/**
 *  Symbol 最新價
 */
@property (nonatomic, strong, nonnull) NSDecimalNumber *sym_price;

/**
 *  股票价格变动量
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_upDownAmt;

/**
 *  Symbol 股票价格变动百分比
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_upDownRatio;

/**
 * 振幅
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_amplitude;
/**
 *  Optional，表示現在這個商品是否己經過了交易時間，Client在收到此旗標為1時，應將Client的Market Data變成灰色(收盤顏色）。
 */
@property (nonatomic) EnumQuoteStale sym_stale;

/**
 *  昨收价
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_preClose;
@end

@interface LightWeightCategoryCore : NSObject

/**
 *  Category ID
 *  五分钟榜单：FIVE_MINUTES_RANKING
 *  振幅榜： AMPLITUDE_RANK
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
@property (nullable, nonatomic, strong,readonly) NSArray<LightWeightCategoryDataCore *> *data;

@end

@interface LightWeightRankUpdate : JPacketReceiveBase

/**
 *  SC: A股
 HK: 港股
 US: 美股
 GLOBAL: 全球
 */
@property (nonnull, nonatomic, strong, readonly) NSString *type;

/**
 *  An array of Category，要查詢的分類
 */
@property (nullable, nonatomic, strong, readonly) NSArray<LightWeightCategoryCore *> *categories;
/**
 *  預留以備優化使用
 */
@property (nonatomic, assign, readonly) NSInteger timestamp;

@end
