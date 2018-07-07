//
//  AccountResetUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "AccountResetUpdate.h"

@implementation AccountResetUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _txid = nil;
        _userid = nil;
        _account = nil;
        _market = nil;
        _coinid = nil;
        _err = nil;
        _msg = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _txid = [dict objectForKey:@(2)];
    _userid = [dict objectForKey:@(3)];
    _account = [dict objectForKey:@(4)];
    _coinid = [dict objectForKey:@(5)];
    
    if ([[dict objectForKey:@(6)] isKindOfClass:[NSString class]])
        _err = [dict objectForKey:@(6)];
    
    if ([[dict objectForKey:@(7)] isKindOfClass:[NSString class]])
        _msg = [dict objectForKey:@(7)];
    
}
@end
