//
//  JPacketSendBase.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@implementation JPacketSendBase

- (id)init
{
    self = [super init];
    if (self)
    {
        self.pt = JPacket_INVALID;
        self.seq = JPacket_INVALID;
        self.waitingPacket = EnumPacketPT_None;
    }
    
    return self;
}
- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

+ (int)getSeqIncreased
{
    if (gSendSeq > INT_FAST32_MAX)
        gSendSeq = 0;
    
    return gSendSeq++;
}

- (void)startSendoutTimer
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.handlerTimeout respondsToSelector:@selector(handleJPacketTimeout:)])
        {
            [self.timer invalidate];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:JPacket_SendTimeout
                                                      target:self.handlerTimeout
                                                    selector:@selector(handleJPacketTimeout:)
                                                    userInfo:self
                                                     repeats:NO];
        }
    });
}
- (void)stopSendoutTimer
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.timer invalidate];
        self.timer = nil;
    });
}
@end
