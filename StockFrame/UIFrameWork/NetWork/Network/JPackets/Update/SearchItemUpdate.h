//
//  SearchItemUpdate.h
//  MasterDataManager
//
//  Created by ljt on 2017/9/18.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface SearchItemUpdateDataCore : NSObject
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
 *  昨收价
 */
@property (nonatomic, strong, nullable) NSString *underlying;

/**
 *  Symbol 代码
 */
@property (nonatomic, strong, nonnull) NSString *sym_code;

/**
 *  Symbol 价格
 */
@property (nonatomic, strong, nonnull) NSDecimalNumber *sym_price;

/**
 *  涨跌幅
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_ratio;

/**
 *  涨跌额
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_change;

/**
 * 行使价
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *exercisePrice;
/**
 * 到期日
 */
@property (nonatomic, assign) NSInteger maturity;

/**
 * 成交额
 */
@property (nonatomic, strong, nullable) NSDecimalNumber *turnover;
/**
 * 类型
 */
@property (nonatomic, strong, nullable) NSString  *hktype;

/**
 *  Optional，表示現在這個商品是否己經過了交易時間，Client在收到此旗標為1時，應將Client的Market Data變成灰色(收盤顏色）。
 */
@property (nonatomic) EnumQuoteStale sym_stale;

@end


@interface SearchItemUpdate : JPacketReceiveBase
/**
 * 1 是普通股； 2 窝轮 ； 3 牛熊
 */
@property (strong, nonatomic, nonnull) NSString *hktype;

/**
 * vendorCN：发行商列表
 vendorEN:发行商列表
 vendorTW:发行商列表
 side：  认购,认沽,牛证,熊证
 到期日：  所有,<3月,3-6月,6-12月,>12月
 价内/外： 所有,价内,价外
 */
@property (strong, nonatomic, nonnull) NSDictionary *filter;

/**
 * 当前的页数，client翻页的依据
 */
@property (assign, nonatomic) NSInteger page;

/**
 * 结果总数
 */
@property (assign, nonatomic) NSInteger total;

/**
 * 结果总数
 */
@property (strong, nonatomic, nonnull) NSString *side;


/**
 * 单页多少
 */
@property (assign, nonatomic) NSInteger size;

/**
 * 排序
 */
@property (assign, nonatomic) NSInteger desc;

/**
 * 价内价外
 */
@property (assign, nonatomic) NSInteger inOut;

/**
 *  An array of Category，要查詢的分類
 */
@property (strong, nonatomic, nonnull) NSArray<SearchItemUpdateDataCore *> *categories;
/**
 *  預留以備優化使用
 */
@property (assign, nonatomic) NSInteger timestamp;

@end
