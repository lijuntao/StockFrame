//
//  JPacketHelperProtocol.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketHelper.h"
#import "JPacketHelper+Protocol.h"
#import "JPacketReceiveBase.h"
#import "NetworkDefinition.h"
#import "JPacketPTMap.h"

@implementation JPacketHelper (Protocol)

- (JPacketReceiveBase *)makeProtocol:(NSDictionary *)dictData
{
    if (dictData == nil || [dictData count] == 0)
        return nil;
    
    NSNumber *numPT = [dictData objectForKey:@(1)];
    if (numPT == nil)
        return nil;
    NSString *strClassName = [[JPacketPTMap sharedInstance] getPacketReceiveClassName:numPT];
    if (strClassName == nil)
    {
        LogDebug(@"unknown packet: %@",numPT);
        return nil;
    }
    JPacketReceiveBase *base = [[NSClassFromString(strClassName) alloc] init];
    [base fillData:dictData];
    
    return base;
}

@end
