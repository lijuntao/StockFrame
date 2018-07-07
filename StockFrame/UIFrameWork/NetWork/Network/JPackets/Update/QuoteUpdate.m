//
//  QuoteUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "QuoteUpdate.h"
@implementation QuoteUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _err = nil;
        _msg = nil;
        _ID = nil;
        _tdate = JPacket_INVALID;
        _d = nil;
        _stale = EnumQuoteStale_None;
        _status = 0;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
//    static int i = 0;
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    if ([[dict allKeys] containsObject:@(2)])
        self.seq = [[dict objectForKey:@(2)] intValue];
    
    _err = [dict objectForKey:@(3)];
    _msg = [dict objectForKey:@(4)];
    _ID = [dict objectForKey:@(5)];
    
    if ([[dict allKeys] containsObject:@(6)])
        _tdate = [[dict objectForKey:@(6)] intValue];
    
    _d = [dict objectForKey:@(7)];
    
    if ([[dict allKeys] containsObject:@(8)])
        _stale = [[dict objectForKey:@(8)] intValue];
    
    if ([[dict allKeys] containsObject:@(9)])
        _status = [[dict objectForKey:@(9)] intValue];
    
    if ([[dict allKeys] containsObject:@(10)]){
        NSUInteger num = [[dict objectForKey:@(10)] intValue];
        _append = num==0;
    }
}
@end
