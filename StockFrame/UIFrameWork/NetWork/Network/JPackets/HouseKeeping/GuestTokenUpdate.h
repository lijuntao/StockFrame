//
//  GuestTokenUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface GuestTokenUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *token;

@end
