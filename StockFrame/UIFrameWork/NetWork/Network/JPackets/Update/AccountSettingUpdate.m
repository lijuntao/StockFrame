//
//  AccountSettingUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "AccountSettingUpdate.h"

@implementation AccountSettingUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _user = nil;
        _account = nil;
        _stoploss = nil;
        _defq = nil;
        _company_sl = nil;
        _leverage = nil;
        _commission = nil;
        _trailingStop = nil;
        _trading_type = nil;
        _daily_sl = nil;
        _account_sl = nil;
        _account_slp = nil;
        _max_daily_sl = nil;
        _startTimeBegin = nil;
        _stopTimeEnd = nil;
        _company_slp = nil;
        _max_daily_slp = nil;
        _err = nil;
        _msg = nil;
        _defq2 = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _user = [dict objectForKey:@(2)];
    _account = [dict objectForKey:@(3)];
    _stoploss = [dict objectForKey:@(4)];
    _defq = [dict objectForKey:@(5)];
    _company_sl = [dict objectForKey:@(6)];
    _leverage = [dict objectForKey:@(7)];
    _commission = [dict objectForKey:@(8)];
    _trailingStop = [dict objectForKey:@(9)];
    _trading_type = [dict objectForKey:@(10)];
    _daily_sl = [dict objectForKey:@(11)];
    _account_sl = [dict objectForKey:@(12)];
    _max_daily_sl = [dict objectForKey:@(13)];
    _startTimeBegin = [dict objectForKey:@(14)];
    _stopTimeEnd = [dict objectForKey:@(15)];
    _company_slp = [dict objectForKey:@(16)];
    _max_daily_slp = [dict objectForKey:@(17)];
    _err = [dict objectForKey:@(18)];
    _msg = [dict objectForKey:@(19)]; 
    _account_slp = [dict objectForKey:@(21)];
    _defq2 = [dict objectForKey:@(22)];
}
@end
