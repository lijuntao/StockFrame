//
//  GetLightWeightRank.h
//  MasterDataManager
//
//  Created by ljt on 2017/7/24.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"
@class WmRankingCategoryItem;
@interface GetLightWeightRank : JPacketSendBase

//@property (nonatomic, assign) NSInteger seq;

/**
 *  SH: 滬股通
 HK: 港股
 US: 美股
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

- (id)initWithType:(NSString *)type
        categories:(NSArray *)categories
         timestamp:(NSInteger)timestamp;

@end
