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

@implementation JPacketHelper (Protocol)

- (JPacketReceiveBase *)makeProtocol:(NSDictionary *)dictData
{
    if (dictData == nil || [dictData count] == 0)
        return nil;
    
    NSNumber *numPT = [dictData objectForKey:@(1)];
    if (numPT == nil)
        return nil;
    
    NSString *strClassName = [_dictPacketMapping objectForKey:numPT];
    if (strClassName == nil)
    {
//        LogInfo(@"unknown packet: %@",numPT);
        [DLog logInfo:[NSString stringWithFormat:@"unknown packet: %@",numPT]];
        return nil;
    }
#if DEBUG_MODE
    DLog(@"Packet received: %@ (%@)", strClassName, numPT);
#endif
    JPacketReceiveBase *base = [[NSClassFromString(strClassName) alloc] init];
    [base fillData:dictData];
    
    return base;
}

@end
