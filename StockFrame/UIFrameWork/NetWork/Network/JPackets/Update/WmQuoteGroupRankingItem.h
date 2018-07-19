//
//  WmGroupRankingItem.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/4.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManagerDefinition.h"
#import "WmRandomValueBaseItem.h"
@class WmGroupCategorySymbolItem;
@class WmCategoryDataCore;
NS_ASSUME_NONNULL_BEGIN
@interface WmGroupCategoryBaseItem : WmRandomValueBaseItem
@property (nonatomic, assign) BOOL isEmpty;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) EnumQuoteStale stale;

-(void) fillData:(WmCategoryDataCore *)dataCore withLanguage:(NSString *)language;

@end

// 分類中為商品列表 e.g. 滬股通、漲幅榜、跌幅榜、美股(中概股、明星股)、全球(常用、歐美指數、亞太指數、大宗商品)
@interface WmGroupCategorySymbolItem : WmGroupCategoryBaseItem
@property (nonatomic, strong, nullable) NSDecimalNumber *price;
@property (nonatomic, strong, nullable) NSString *formatPrice;
@property (nonatomic, strong, nullable) NSDecimalNumber *chgpct;
@end

// 分類中為商品列表 e.g. 成交額榜
@interface WmGroupCategoryAmountItem : WmGroupCategoryBaseItem
@property (nonatomic, strong, nullable) NSDecimalNumber *price;
@property (nonatomic, strong, nullable) NSString *formatPrice;
@property (nonatomic, strong, nullable) NSDecimalNumber *amount;
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_ratio;
@end


/**
 * 港股页面下，AH股榜单所需数据Item
 */
@interface WmGroupCategoryAHStockItem : WmGroupCategoryBaseItem
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_price; //最新价
@property (nonatomic, strong, nullable) NSString *sym_price_str; //最新价(字符串格式)
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_ratio; //涨跌幅
@property (nonatomic, assign) NSInteger sym_hk_con; //1表示是（沪）深股通，0表示不是
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_turnover; //换手率
@property (nonatomic, strong, nullable) NSString *sym_ashares; //A股的symbol（AH榜单专用）
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_aratio; //A股的涨跌幅（AH榜单专用）
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_premium; //AH股溢价率
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_aprice; //a股的价格
@end

// 分類中為行業列表 e.g. 熱門行業
@interface WmGroupCategoryIndustryItem : WmGroupCategoryBaseItem
@property (nonatomic, strong) WmGroupCategorySymbolItem *leadSymbol;
@property (nonatomic, strong, nullable) NSDecimalNumber *chgpct;
@end

// 分類中為行業列表 e.g. 全球(外匯市場、人民幣牌價)
@interface WmGroupCategoryForexItem : WmGroupCategoryBaseItem
@property (nonatomic, strong, nullable) NSDecimalNumber *price;
@property (nonatomic, strong, nullable) NSString *formatPrice;
@property (nonatomic, strong, nullable) NSDecimalNumber *chg;
@property (nonatomic, strong, readonly) NSString *formatChg;

@end

// 换手率榜列表
@interface WmGroupCategoryTurnoverItem : WmGroupCategoryBaseItem
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_price;
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_turnover; //换手率
@property (nonatomic, strong, nullable) NSDecimalNumber *sym_ratio;

@end

@interface WmQuoteCategory : WmRandomValueBaseItem

/**
 *  SH
 
    MAINUP
 
    MAINDOWN
 
    MAINAMT
 
    INDUSTRY
 
    行業 ID
 */
@property (nonatomic,strong) NSString *categoryId;

@property (nonatomic, assign) NSInteger level;

/**
 *  滬股通、港股、美股 通用資料格式
 */
@property (nonatomic, strong) NSMutableArray<WmGroupCategoryBaseItem *> *data;

/**
 *  添加新的商品或行業
 *
 *  @param item 新的商品或行業
 */
- (void) addCategoryOrSymbol:(WmGroupCategoryBaseItem *)item;

@end


@interface WmQuoteGroupRankingItem : WmRandomValueBaseItem

@property (nonatomic, strong) NSString *type;

/**
 *  通用level, 由於dataCenter API設計，不會有同一封包不同level情況出現
 */
@property (nonatomic, assign) NSInteger level;

@property (nonatomic, strong) NSMutableDictionary<NSString *,WmQuoteCategory *> *dataDictionary;

-(void) addIndustryOrSymbol:(WmGroupCategoryBaseItem *)item category:(NSString *)categoryId level:(NSInteger)level;
/**
 *  根據分類id 取的該分類所有資料
 *
 *  @param categoryId 分類id
 *
 *  @return array of WmGroupCategoryBaseItem
 */
- (NSArray<WmGroupCategoryBaseItem *> *) getDataWithCategoryId:(NSString *)categoryId;

- (NSArray<NSString *> *) getCategoryList;

- (nullable WmGroupCategoryBaseItem *) getDataWithItemId:(nonnull NSString *)itemId;
@end
NS_ASSUME_NONNULL_END

