//
//  DisconnectStatus.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface DisconnectStatus : JPacketReceiveBase

@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@end
