//
//  JPacketBase.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/10/3.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketBase.h"

@implementation JPacketBase
-(id) nullFilter:(id)obj
{
    if ([obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return obj;
}

@end
