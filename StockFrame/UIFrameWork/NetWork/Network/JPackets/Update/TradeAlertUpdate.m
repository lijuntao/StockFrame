//
//  TradeAlertUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "TradeAlertUpdate.h"

@implementation TradeAlertUpdateCore

- (id)init
{
    self = [super init];
    if (self)
    {
        _msgid = nil;
        _datetime = nil;
        _user = nil;
        _sym = nil;
        _price = nil;
        _qty = nil;
        _content = nil;
        _reason = JPacket_INVALID;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _msgid = [dict objectForKey:@(1)];
    _datetime = [dict objectForKey:@(2)];
    _user = [dict objectForKey:@(3)];
    _sym = [dict objectForKey:@(4)];
    _price = [dict objectForKey:@(5)];
    _qty = [dict objectForKey:@(6)];
    _content = [dict objectForKey:@(7)];
    
    if ([dict objectForKey:@(8)])
        _reason = [[dict objectForKey:@(8)] intValue];
    
}

@end

@implementation TradeAlertUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _txid = nil;
        _user = nil;
        _d = nil;
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
    _user = [dict objectForKey:@(3)];
    
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dictCore in [dict objectForKey:@(4)])
    {
        TradeAlertUpdateCore *core = [TradeAlertUpdateCore new];
        [core fillData:dictCore];
        [arr addObject:core];
    }
    _d = arr;
    
    _err = [dict objectForKey:@(5)];
    _msg = [dict objectForKey:@(6)];
}
@end
