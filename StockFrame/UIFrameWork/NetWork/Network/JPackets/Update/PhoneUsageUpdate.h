//
//  PhoneUsageUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/7/21.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface PhoneUsageUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) BOOL is_used;
@property (nonatomic, strong) NSString* user;

@end
