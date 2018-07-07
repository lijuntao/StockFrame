//
//  CreateUser.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface CreateUser : JPacketSendBase

//@property (nonatomic, assign, readonly) int seq;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, strong, readonly) NSString *pwd;
@property (nonatomic, strong, readonly) NSString *email;
@property (nonatomic, strong, readonly) NSString *phone;
@property (nonatomic, assign, readonly) EnumUserRoleType uType;
@property (nonatomic, strong, readonly) NSString *country;
@property (nonatomic, strong, readonly) NSString *langCode;
@property (nonatomic, assign, readonly) BOOL genId;

- (id)initWithUserID:(NSString *)strUserID
            password:(NSString *)strPwd
               email:(NSString *)strEmail
               phone:(NSString *)strPhone
             country:(NSString *)strCountry
                lang:(NSString *)strLanguage
               genId:(BOOL)genId;
@end
