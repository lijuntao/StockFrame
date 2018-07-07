//
//  TokenUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface TokenUpdate : JPacketReceiveBase

@property (nonatomic, strong, nullable) NSString *err;
@property (nonatomic, strong, nullable) NSString *msg;
@property (nonatomic, strong, nullable) NSString *token;

@end
