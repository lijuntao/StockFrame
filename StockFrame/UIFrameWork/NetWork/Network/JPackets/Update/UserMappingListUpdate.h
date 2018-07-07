//
//  UserMappingListUpdate.h
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/6/4.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface ThirdPartyUser : NSObject

@property (nonatomic, strong) NSString *thirdPartyID;
@property (nonatomic, assign) EnumUserRoleType utype;

@end

@interface UserMappingListUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSArray *d;

@end
