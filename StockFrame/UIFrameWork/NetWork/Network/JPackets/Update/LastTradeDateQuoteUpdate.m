//
//  LastTradeDateQuoteUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "LastTradeDateQuoteUpdate.h"

@implementation LastTradeDateQuoteUpdateCore

- (id)init
{
    self = [super init];
    if (self)
    {
        _trddate = nil;
        _symbol = nil;
        _lprc = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    if ([[dict objectForKey:@(1)] isKindOfClass:[NSString class]])
        _trddate = [dict objectForKey:@(1)];
    
    if ([[dict objectForKey:@(2)] isKindOfClass:[NSString class]])
        _symbol = [dict objectForKey:@(2)];
    
    if ([[dict objectForKey:@(3)] isKindOfClass:[NSDecimalNumber class]])
        _lprc = [dict objectForKey:@(3)];
    
}
@end

@implementation LastTradeDateQuoteUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _market = nil;
        _d = nil;
        _err = nil;
        _msg = nil;
        _sesname = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    self.seq = [[dict objectForKey:@(2)] intValue];
    
    if ([[dict objectForKey:@(3)] isKindOfClass:[NSString class]])
        _market = [dict objectForKey:@(3)];
    
    if ([[dict objectForKey:@(4)] isKindOfClass:[NSArray class]])
    {
        NSArray *arr = [dict objectForKey:@(4)];
        NSMutableArray *arrCore = [NSMutableArray new];
        for (NSDictionary *dictCore in arr)
        {
            LastTradeDateQuoteUpdateCore *core = [LastTradeDateQuoteUpdateCore new];
            [core fillData:dictCore];
            [arrCore addObject:core];
        }
        _d = arrCore;
    }
    
    if ([[dict objectForKey:@(5)] isKindOfClass:[NSString class]])
        _err = [dict objectForKey:@(5)];
   
    if ([[dict objectForKey:@(6)] isKindOfClass:[NSString class]])
        _msg = [dict objectForKey:@(6)];
    
    if ([[dict objectForKey:@(7)] isKindOfClass:[NSString class]])
        _sesname = [dict objectForKey:@(7)];
    
}
@end
