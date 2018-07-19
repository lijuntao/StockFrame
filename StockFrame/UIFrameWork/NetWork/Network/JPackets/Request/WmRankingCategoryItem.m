//
//  WmRankingCategoryItem.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/4.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmRankingCategoryItem.h"

@implementation WmRankingCategoryItem

- (nonnull instancetype)initCategory:(nonnull NSString *)category
                               level:(NSInteger)level
                                desc:(NSInteger)desc;
{
    self = [super init];
    if (self) {
        _Id = category;
        _level = level;
        _desc = desc;
    }
    return self;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"category: %@\n\t  level:%ld\n\t  desc: %ld", _Id,(long)_level,(long)_desc];
}
@end
