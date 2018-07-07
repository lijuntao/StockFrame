//
//  AccountResetUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface AccountResetUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSString *coinid;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;

@end
