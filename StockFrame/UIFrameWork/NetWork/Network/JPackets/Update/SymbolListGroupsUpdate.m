//
//  SymbolListUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "SymbolListGroupsUpdate.h"

@implementation SymbolListGroupsUpdateCore

- (id)init
{
    self = [super init];
    if (self)
    {
        _grpID = nil;
        _grpName = nil;
        _symCount = 0;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _grpID = [dict objectForKey:@(1)];
    _grpName = [dict objectForKey:@(2)];
    _symCount = [[dict objectForKey:@(3)] intValue];
    
}

@end

@implementation SymbolListGroupsUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _user = nil;
        _market = nil;
        _type = EnumSymbolListGroupType_None;
        _txid = nil;
        _err = nil;
        _msg = nil;
        _d = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _user = [dict objectForKey:@(2)];
    _market = [dict objectForKey:@(3)];
    _type = [[dict objectForKey:@(4)] intValue];
    _txid = [dict objectForKey:@(5)];
    
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dictCore in [dict objectForKey:@(6)])
    {
        SymbolListGroupsUpdateCore *core = [SymbolListGroupsUpdateCore new];
        [core fillData:dictCore];
        [arr addObject:core];
    }
    _d = arr;
    _err = [dict objectForKey:@(7)];
    _msg = [dict objectForKey:@(8)];
    
}
@end
