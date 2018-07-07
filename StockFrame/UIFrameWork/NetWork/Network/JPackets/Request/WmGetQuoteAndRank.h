//
//  WmGetQuoteAndRank.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/4.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"
@class WmRankingCategoryItem;
@interface WmGetQuoteAndRank : JPacketSendBase

//@property (nonatomic, assign) NSInteger seq;

/**
 *  SH: 滬股通
    HK: 港股
    US: 美股
    GLOBAL: 全球
 */
@property (nonatomic, strong, readonly) NSString *type;
/**
 *  An array of Category，要查詢的分類
 */
@property (nonatomic, strong, readonly) NSArray<WmRankingCategoryItem *> *categories;
/**
 *  預留以備優化使用
 */
@property (nonatomic, assign, readonly) NSInteger timestamp;


/**
 * 添加此字段，返回换手率信息
 */
@property (nonatomic, assign, readonly) NSInteger more;
- (id)initWithType:(NSString *)type
        categories:(NSArray *)categories
         timestamp:(NSInteger)timestamp;

@end
