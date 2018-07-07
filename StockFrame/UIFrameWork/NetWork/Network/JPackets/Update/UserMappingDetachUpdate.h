//
//  UserMappingDetachUpdate.h
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/5/29.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"


@interface UserMappingDetachUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *user_3rd;
@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, assign) BOOL is_attach;
@property (nonatomic, assign) EnumUserRoleType utype;


@end
