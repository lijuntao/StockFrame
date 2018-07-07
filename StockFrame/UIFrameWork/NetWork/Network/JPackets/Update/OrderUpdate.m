//
//  OrderUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "OrderUpdate.h"

@implementation OrderUpdateCore

- (id)init
{
    self = [super init];
    if (self)
    {
        _ID = nil;
        _type = JPacket_INVALID;
        _ostatus = JPacket_INVALID;
        _err = nil;
        _msg = nil;
        _side = JPacket_INVALID;
        _price = nil;
        _qty = nil;
        _cumqty = nil;
        _avgprice = nil;
        _sym = nil;
        _otype = JPacket_INVALID;
        _strategy = JPacket_INVALID;
        _strategy_prc1 = nil;
        _reason = EnumOrderReason_Normal;
        
    }
    
    return self;
}

@end

@implementation OrderUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _account = nil;
        _d = nil;
        _txid = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _account = [dict objectForKey:@(2)];
    NSArray *d = [dict objectForKey:@(3)];
    NSMutableArray *arr = [NSMutableArray new];
    
    for (NSDictionary *dictData in d)
    {
        OrderUpdateCore *core = [OrderUpdateCore new];
        
        [core setID:[dictData objectForKey:@(1)]];
        if ([dictData objectForKey:@(2)])
            [core setType:[[dictData objectForKey:@(2)] intValue]];
        
        if ([dictData objectForKey:@(3)])
            [core setOstatus:[[dictData objectForKey:@(3)] intValue]];
        
        [core setErr:[dictData objectForKey:@(4)]];
        [core setMsg:[dictData objectForKey:@(5)]];
        
        if ([[dictData allKeys] containsObject:@(6)])
            [core setSide:[[dictData objectForKey:@(6)] intValue]];
        
        [core setPrice:[dictData objectForKey:@(7)]];
        [core setQty:[dictData objectForKey:@(8)]];
        [core setCumqty:[dictData objectForKey:@(9)]];
        [core setAvgprice:[dictData objectForKey:@(10)]];
        [core setSym:[dictData objectForKey:@(11)]];
        
        if ([[dictData allKeys] containsObject:@(12)])
            [core setOtype:[[dictData objectForKey:@(12)] intValue]];
        
        if ([[dictData allKeys] containsObject:@(13)])
            [core setTime:[dictData objectForKey:@(13)]];
        
        if ([[dictData allKeys] containsObject:@(14)])
            [core setStrategy:[[dictData objectForKey:@(14)] intValue]];

        [core setStrategy_prc1:[dictData objectForKey:@(15)]];
        
        if ([[dictData allKeys] containsObject:@(16)])
            [core setReason:[[dictData objectForKey:@(16)] intValue]];
        
        [arr addObject:core];
    }
    _d = arr;
    
    _txid = [dict objectForKey:@(4)];
    
}
@end
