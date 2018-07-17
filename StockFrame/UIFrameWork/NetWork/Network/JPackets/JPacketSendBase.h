//
//  JPacketSendBase.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPacketBase.h"

static int gSendSeq = 0;

@protocol PacketTimeoutHandler <NSObject>

@optional
- (void)handleJPacketTimeout:(NSTimer *)timer;

@end

@interface JPacketSendBase : JPacketBase
{
}
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong, readonly) NSDictionary *dict;
@property (nonatomic, weak) id<PacketTimeoutHandler> handlerTimeout;
@property (nonatomic, assign) EnumPacketPT waitingPacket;

+ (int)getSeqIncreased;
- (void)startSendoutTimer;
- (void)stopSendoutTimer;
@end
