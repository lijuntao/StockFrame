//
//  WmSmsLoginUpdate.h
//  MasterDataManager
//
//  Created by 姚晨峰 on 2017/5/15.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface WmSmsLoginUpdate : JPacketReceiveBase
@property (nonatomic, copy, readonly,nullable) NSString *err;
@property (nonatomic, copy, readonly,nullable) NSString *msg;

@property (nonatomic, copy, readonly,nullable) NSString *phone;
@property (nonatomic, copy, readonly,nullable) NSString *sms_token;
@property (nonatomic, copy, readonly,nullable) NSString *expire;
@end
