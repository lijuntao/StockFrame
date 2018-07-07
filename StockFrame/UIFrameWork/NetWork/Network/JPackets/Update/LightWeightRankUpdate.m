//
//  LightWeightRankUpdate.m
//  MasterDataManager
//
//  Created by ljt on 2017/7/24.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "LightWeightRankUpdate.h"

@implementation LightWeightCategoryDataCore

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _sym_code = dictionary[@(1)];
        _sym_en = dictionary[@(2)];
        _sym_cn = dictionary[@(3)];
        _sym_tw = dictionary[@(4)];
        _sym_price = dictionary[@(5)];
        _sym_upDownAmt = dictionary[@(6)];
        _sym_upDownRatio = dictionary[@(7)];
        _sym_amplitude = dictionary[@(8)];
        _sym_stale = [dictionary[@(9)] intValue];
        _sym_preClose = dictionary[@(10)];
    }
    return self;
}

@end

@implementation LightWeightCategoryCore

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _Id = dictionary[@(1)];
        _desc =  [dictionary[@(2)] intValue];
        _level =  0;
        
        
        NSArray *tmpData = dictionary[@(4)];
        NSMutableArray *datas = [NSMutableArray new];
        for (NSDictionary *dictionary in tmpData) {
            LightWeightCategoryDataCore *core = [[LightWeightCategoryDataCore alloc] initWithDictionary:dictionary];
            [datas addObject:core];
        }
        _data = datas;
    }
    return self;
}

@end

@implementation LightWeightRankUpdate

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    self.seq = [dict[@(2)] intValue];
    _type = dict[@(3)];
    NSArray *tmpCategories = dict[@(5)];
    NSMutableArray *categories = [NSMutableArray new];
    for (NSDictionary *dic in tmpCategories) {
        
        LightWeightCategoryCore *categoryCore = [[LightWeightCategoryCore alloc] initWithDictionary:dic];
        [categories addObject:categoryCore];
    }
    _categories = categories;
    
    _timestamp = [dict[@(4)] intValue];
}

@end
