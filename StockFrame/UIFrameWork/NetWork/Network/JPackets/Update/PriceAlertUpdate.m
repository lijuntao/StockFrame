//
//  PriceAlertUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "PriceAlertUpdate.h"

@implementation PriceAlertUpdateCore

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
        _content = nil;
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
    _content = [dict objectForKey:@(6)]; 
    
}

@end

@implementation PriceAlertUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _txid = nil;
        _user = nil;
        _type = JPacket_INVALID;
        _d = nil;
        _errMsgid = nil;
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
    
    if ([dict objectForKey:@(4)])
        _type = [[dict objectForKey:@(4)] intValue];
    
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dictCore in [dict objectForKey:@(5)])
    {
        PriceAlertUpdateCore *core = [PriceAlertUpdateCore new];
        [core fillData:dictCore];
        core.type = _type;
        [arr addObject:core];
    }
    _d = arr;
    
    _errMsgid = [dict objectForKey:@(6)];
    _err = [dict objectForKey:@(7)];
    _msg = [dict objectForKey:@(8)];
}
@end
