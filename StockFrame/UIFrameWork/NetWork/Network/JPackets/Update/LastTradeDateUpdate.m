//
//  LastTradeDateUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "LastTradeDateUpdate.h"

@implementation LastTradeDateUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _market = nil;
        _trddate = nil;
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
    
    self.seq = [[dict objectForKey:@(2)] intValue];
    
    if ([[dict objectForKey:@(3)] isKindOfClass:[NSString class]])
        _market = [dict objectForKey:@(3)];

    if ([[dict objectForKey:@(4)] isKindOfClass:[NSString class]])
        _trddate = [dict objectForKey:@(4)];
    
    if ([[dict objectForKey:@(5)] isKindOfClass:[NSString class]])
        _err = [dict objectForKey:@(5)];
   
    if ([[dict objectForKey:@(6)] isKindOfClass:[NSString class]])
        _msg = [dict objectForKey:@(6)];
    
}
@end
