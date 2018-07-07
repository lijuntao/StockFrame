//
//  MarketStatusUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "MarketStatusUpdate.h"

@implementation MarketStatusUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _ex = nil;
        _status = JPacket_INVALID;
        _sesname = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    self.seq = JPacket_INVALID;
    _ex = [dict objectForKey:@(2)];
    
    if ([[dict allKeys] containsObject:@(3)])
        _status = [[dict objectForKey:@(3)] intValue];
    
    if ([[dict allKeys] containsObject:@(6)])
        _sesname = [dict objectForKey:@(6)];
}
@end
