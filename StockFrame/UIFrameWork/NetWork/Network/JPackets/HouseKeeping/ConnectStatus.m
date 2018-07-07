//
//  ConnectStatus.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/10/3.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "ConnectStatus.h"

@implementation ConnectStatus


- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    if ([[dict allKeys] containsObject:@(2)])
        self.seq = [[dict objectForKey:@(2)] intValue];
    
    _key = [dict objectForKey:@(3)];
    _time = [dict objectForKey:@(4)];
    _tdiff = [[dict objectForKey:@(5)] intValue];
    _tzid = [dict objectForKey:@(6)];
    _exchange_tzs = [dict objectForKey:@(7)];
}
@end
