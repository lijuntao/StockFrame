//
//  SearchItemUpdate.m
//  MasterDataManager
//
//  Created by ljt on 2017/9/18.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "SearchItemUpdate.h"

@implementation SearchItemUpdateDataCore

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _sym_code = dictionary[@(1)];
        _sym_en = dictionary[@(4)];
        _sym_cn = dictionary[@(2)];
        _sym_tw = dictionary[@(3)];
        _underlying = dictionary[@(12)];
        _sym_price = dictionary[@(6)];
        _sym_ratio = dictionary[@(5)];
        _sym_change = dictionary[@(7)];
        _exercisePrice = dictionary[@(8)];
        _maturity = [dictionary[@(9)] integerValue];
        _turnover = dictionary[@(10)];
        _hktype = dictionary[@(11)];
        _sym_stale = [dictionary[@(13)] intValue];
    }
    return self;
}

@end

@implementation SearchItemUpdate

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    self.seq = [dict[@(2)] integerValue];
    _hktype = dict[@(3)];
    _filter = dict[@(4)];
    _page = [dict[@(5)] integerValue];
    _total = [dict[@(6)] integerValue];
    _side = dict[@(7)];
    _size = [dict[@(13)] integerValue];
    _desc = [dict[@(12)] integerValue];
    _inOut = [dict[@(8)] integerValue];
    
    NSArray *tmpCategories = dict[@(14)];
    NSMutableArray *categories = [NSMutableArray new];
    for (NSDictionary *dic in tmpCategories) {
        
        SearchItemUpdateDataCore *categoryCore = [[SearchItemUpdateDataCore alloc] initWithDictionary:dic];
        [categories addObject:categoryCore];
    }
    _categories = categories;
    
    _timestamp = [dict[@(15)] intValue];
}


@end
