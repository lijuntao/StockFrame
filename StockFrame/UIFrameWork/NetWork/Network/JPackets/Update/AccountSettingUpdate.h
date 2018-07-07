//
//  AccountSettingUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface AccountSettingUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSDecimalNumber *stoploss;
@property (nonatomic, strong) NSDecimalNumber *defq;
@property (nonatomic, strong) NSString *defq2;
@property (nonatomic, strong) NSDecimalNumber *company_sl;
@property (nonatomic, strong) NSDecimalNumber *leverage;
@property (nonatomic, strong) NSDecimalNumber *commission;
@property (nonatomic, strong) NSDecimalNumber *trailingStop;
@property (nonatomic, strong) NSNumber *trading_type;
@property (nonatomic, strong) NSDecimalNumber *daily_sl;
@property (nonatomic, strong) NSDecimalNumber *account_sl;
@property (nonatomic, strong) NSDecimalNumber *account_slp;
@property (nonatomic, strong) NSDecimalNumber *max_daily_sl;
@property (nonatomic, strong) NSString *startTimeBegin;
@property (nonatomic, strong) NSString *stopTimeEnd;
@property (nonatomic, strong) NSDecimalNumber *company_slp;
@property (nonatomic, strong) NSDecimalNumber *max_daily_slp;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg; 

@end
