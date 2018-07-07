//
//  ConnectChallenge.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/10/3.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "ConnectChallenge.h"

@implementation ConnectChallenge

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    if ([[dict allKeys] containsObject:@(2)])
        self.seq = [[dict objectForKey:@(2)] intValue];
    
    _randomByte = [dict objectForKey:@(3)];
}
@end
