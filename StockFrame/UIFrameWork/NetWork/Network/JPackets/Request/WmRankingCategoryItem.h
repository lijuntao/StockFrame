//
//  WmRankingCategoryItem.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/4.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManagerDefinition.h"
#import "WmRandomValueBaseItem.h"

@interface WmRankingCategoryItem : WmRandomValueBaseItem

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


- (nonnull instancetype)initCategory:(nonnull NSString *)category
                               level:(NSInteger)level
                                desc:(NSInteger)desc;
@end
