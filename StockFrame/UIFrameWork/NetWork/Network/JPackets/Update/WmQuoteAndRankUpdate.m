//
//  WmQuoteAndRankUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/4.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmQuoteAndRankUpdate.h"

@implementation WmCategoryDataCore

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _industry = dictionary[@(1)];
        _industry_en = dictionary[@(2)];
        _industry_cn = dictionary[@(3)];
        _industry_tw = dictionary[@(4)];
        _industry_ratio = dictionary[@(5)];
        _sym = dictionary[@(6)];
        _sym_en = dictionary[@(7)];
        _sym_cn = dictionary[@(8)];
        _sym_tw = dictionary[@(9)];
        _sym_ratio = dictionary[@(10)];
        _sym_price = dictionary[@(11)];
        _amount = dictionary[@(12)];
        _sym_shortname = dictionary[@(13)];
        _sym_stale = [dictionary[@(14)] intValue];
        _sym_chg = dictionary[@(15)];
        _sym_price_str = dictionary[@(16)];
        _sym_section = dictionary[@(17)];
        _sym_change_str = dictionary[@(18)];
        _sym_hk_con = [dictionary[@(19)] integerValue];
        _sym_turnover = dictionary[@(20)];
        _sym_ashares = dictionary[@(21)];
        _sym_aratio = dictionary[@(22)];
        _sym_premium = dictionary[@(23)];
        _sym_aprice = dictionary[@(24)];
    }
    return self;
}

@end

@implementation WmCategoryCore

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _Id = dictionary[@(1)];
        _level = [dictionary[@(2)] intValue];
        _desc =  [dictionary[@(3)] intValue];
        
        NSArray *tmpData = dictionary[@(4)];
        NSMutableArray *datas = [NSMutableArray new];
        for (NSDictionary *dictionary in tmpData) {
            WmCategoryDataCore *core = [[WmCategoryDataCore alloc] initWithDictionary:dictionary];
            [datas addObject:core];
        }
        _data = datas;
    }
    return self;
}

@end

@implementation WmQuoteAndRankUpdate

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    self.seq = [dict[@(2)] intValue];
    _type = dict[@(3)];
    NSArray *tmpCategories = dict[@(4)];
    NSMutableArray *categories = [NSMutableArray new];
    for (NSDictionary *dic in tmpCategories) {
        
        WmCategoryCore *categoryCore = [[WmCategoryCore alloc] initWithDictionary:dic];
        [categories addObject:categoryCore];
    }
    _categories = categories;
    
    _timestamp = [dict[@(5)] intValue];
}

@end
