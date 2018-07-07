//
//  JPacketHelper.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JPacketReceiveBase;
@class JPacketSendBase;

@interface JPacketHelper : NSObject
{
    NSDictionary *_dictPacketMapping;
    NSDecimalNumberHandler *_handler;
}
- (JPacketReceiveBase *)doUnPackData:(NSData *)data withHeader:(BOOL)bHeader outPacketNumber:(unsigned short *)pOutPno;
- (NSData *)doPackWithPacket:(JPacketSendBase *)packet;
@end
