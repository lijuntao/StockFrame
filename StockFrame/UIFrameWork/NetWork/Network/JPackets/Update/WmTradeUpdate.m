//
//  WmTradeUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/23.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmTradeUpdate.h"
@implementation WmTradeUpdateCore

@end
@implementation WmTradeUpdate
- (id)init
{
    self = [super init];
    if (self)
    {
        _user = nil;
        _account = nil;
        _d = nil;
    }
    return self;
}
-(void)fillData:(NSDictionary *)dict{
    [super fillData:dict];
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _user = [dict objectForKey:@(2)];
    _account = [dict objectForKey:@(5)];
    NSArray *d = [dict objectForKey:@(3)];
    
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dictData in d)
    {
        WmTradeUpdateCore *core = [WmTradeUpdateCore new];
        core.sym = dictData[@1];
        core.price = dictData[@2];
        core.qty = dictData[@3];
        core.ostatus = [dictData[@4] intValue];
        core.exchange = dictData[@5];

        core.Id = dictData[@6];
        core.order_type = [dictData[@7] intValue];
        core.time = dictData[@8];
        [arr addObject:core];
    }
    _d = arr;
}
@end
