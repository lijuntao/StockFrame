//
//  WmUnionLogin.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/13.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface WmUnionLogin : JPacketSendBase

@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, strong, readonly) NSString *pwd;
@property (nonatomic, strong, readonly) NSString *country;
@property (nonatomic, strong, readonly) NSString *language;
@property (nonatomic, assign, readonly) EnumLoginType login_type;
@property (nonatomic, strong, readonly) NSString *device;
@property (nonatomic, assign, readonly) NSInteger device_verified;
@property (nonatomic, assign, readonly) NSInteger client;

- (id)initWithUserID:(NSString *)strUserID
            password:(NSString *)strPwd
             country:(NSString *)strCountry
            language:(NSString *)strLang
           loginType:(EnumLoginType)loginType
              device:(NSString *)device
     device_verified:(BOOL)device_verified
              client:(NSInteger) client;

@end
