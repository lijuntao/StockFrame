//
//  ConnectStatus.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/10/3.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface ConnectStatus : JPacketReceiveBase

@property (nonatomic, strong) NSData *key;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger tdiff;
@property (nonatomic, strong) NSString *tzid;
@property (nonatomic, strong) NSArray *exchange_tzs;

@end
