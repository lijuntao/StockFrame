//
//  AccountResetUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface AccountStateUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, assign) EnumAccountState state;

@end
