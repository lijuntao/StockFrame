//
//  UseCoinUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/10/1.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "UseCoinUpdate.h"

@implementation UseCoinUpdate
- (id)init
{
    self = [super init];
    if (self)
    {
        _txid = nil;
        _feautre = JPacket_INVALID;
        _user = nil;
        _err = nil;
        _msg = nil;
        _coins = nil;
        _auto_expand = nil;
        _user = nil;
        _market = nil;
        _used_coins = nil;
        _date_end = nil;
        _date_start = nil;
        _add_cash = nil;
    }
    
    return self;
}


- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _txid = [dict objectForKey:@(2)];
    _feautre = [[dict objectForKey:@(3)] intValue];
    
    
    _coins = [dict objectForKey:@(4)];
    _auto_expand = [dict objectForKey:@(5)];
    _user = [dict objectForKey:@(6)];
    _market = [dict objectForKey:@(7)];
    _err = [dict objectForKey:@(8)];
    _msg = [dict objectForKey:@(9)];
    _used_coins = [dict objectForKey:@(10)];
    _date_start = [dict objectForKey:@(11)];
    _date_end = [dict objectForKey:@(12)];
    _add_cash = [dict objectForKey:@(13)];
    
}
@end
