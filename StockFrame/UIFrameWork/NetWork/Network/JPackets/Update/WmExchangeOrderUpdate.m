//
//  WmExchangeOrderUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/8/8.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmExchangeOrderUpdate.h"
@implementation WmExchangeOrderUpdateCore

@end
@implementation WmExchangeOrderUpdate
- (id)init
{
    self = [super init];
    if (self)
    {
        _user = nil;
        _d = nil;
        _txid = nil;
    }
    return self;
}
-(void)fillData:(NSDictionary *)dict{
    [super fillData:dict];
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _user = [dict objectForKey:@(2)];
    NSArray *d = [dict objectForKey:@(3)];
    _txid = [dict objectForKey:@(4)];
    _account = [dict objectForKey:@(5)];
    
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dictData in d)
    {
        WmExchangeOrderUpdateCore *core = [WmExchangeOrderUpdateCore new];
        core.sym = dictData[@1];
        core.price = dictData[@2];
        core.qty = dictData[@3];
        core.ostatus = [dictData[@4] intValue];
        core.Id = dictData[@5];
        core.order_type = [dictData[@6] intValue];
        core.exchange = dictData[@7];
        core.comment = dictData[@8];
        
        if ([dictData[@9] isKindOfClass:[NSNull class]]) {
            if ([dictData[@18] isKindOfClass:[NSNull class]]) {
                core.time = @"";
            }
            else{
                core.time = dictData[@18];
            }
        }
        else{
            core.time = dictData[@9];
        }
        
        
        core.fillqty = dictData[@10];
        if ([dictData.allKeys containsObject:@11]) {
            core.err = dictData[@11];
        }
        if ([dictData.allKeys containsObject:@12]) {
            core.msg = dictData[@12];
        }
        core.avgprice = dictData[@13];
        core.credit = dictData[@14];
        core.queue_qty = dictData[@15];
        core.working_qty = dictData[@16];
        core.minor_code = [dictData[@17] intValue];
        core.create_time = dictData[@18];
        core.resource = dictData[@19];
        
        if ([dictData.allKeys containsObject:@20]) {
            if ([dictData[@20] isKindOfClass:[NSString class]]) {
                core.instruct = [dictData[@20] intValue];
            }
        }
        
        
        [arr addObject:core];
    }
    _d = arr;
}
@end
