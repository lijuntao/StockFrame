//
//  JPacketReceiveBase.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@implementation JPacketReceiveBase

- (id)init
{
    self = [super init];
    if (self)
    {
        self.pt = JPacket_INVALID;
        self.seq = JPacket_INVALID;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    if ([[dict allKeys] containsObject:@(1)])
        self.pt = [[dict objectForKey:@(1)] intValue];
}

@end
