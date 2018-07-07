//
//  UserUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface UserUpdateAccount : NSObject

@property (nonatomic, strong) NSString *accountID;
@property (nonatomic, strong) NSString *ct;

@end


@interface UserUpdate : JPacketReceiveBase

@property (nonatomic, assign) EnumUserStatusType type;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *def;
@property (nonatomic, assign) EnumUserRoleType utype;
@property (nonatomic, strong) NSString *ct;
@property (nonatomic, strong) NSString *lt;
@property (nonatomic, strong) NSArray *d;
@property (nonatomic, strong) NSString *token;
@end
