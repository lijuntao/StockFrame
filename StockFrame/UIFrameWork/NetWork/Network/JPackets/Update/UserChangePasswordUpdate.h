//
//  UserChangePasswordUpdate.h
//  MasterDataManager
//
//  Created by 姚晨峰 on 16/8/29.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface UserChangePasswordUpdate : JPacketReceiveBase
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@end
