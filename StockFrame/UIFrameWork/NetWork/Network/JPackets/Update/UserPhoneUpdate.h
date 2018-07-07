//
//  UserPhoneUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/21.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface UserPhoneUpdate : JPacketReceiveBase

@property (nonatomic, strong, readonly) NSString *txid;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, strong, readonly,nullable) NSString *phone;
@property (nonatomic, strong, readonly,nullable) NSString *err;
@property (nonatomic, strong, readonly,nullable) NSString *msg;
@end
