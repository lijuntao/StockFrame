//
//  ConnectChallenge.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/10/3.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface ConnectChallenge : JPacketReceiveBase

@property (nonatomic, strong) NSData *randomByte;
@end
