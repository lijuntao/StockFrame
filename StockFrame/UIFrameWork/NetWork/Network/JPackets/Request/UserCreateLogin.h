//
//  UserLogin.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h" 

@interface UserCreateLogin : JPacketSendBase

//@property (nonatomic, assign) NSInteger seq;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *pwd;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) EnumUserRoleType utype;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *parseid;
@property (nonatomic, strong) NSString *lang_code;
@property (nonatomic, strong) NSString *org3rdid;     // Facebook, QQ, WeChat等，原始系統 id
@property (nonatomic, strong) NSString *uq3rdid;     // 加上前綴的第三方帳號(長度限制40bytes)
@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSNumber *is_exist_user;
@property (nonatomic, assign) BOOL genId;

- (id)initWithUserID:(NSString *)strUserID
            password:(NSString *)strPwd
               email:(NSString *)strEmail
               phone:(NSString *)strPhone
                type:(EnumUserRoleType)type
             country:(NSString *)strCountry
             parseID:(NSString *)strParseID
            langCode:(NSString *)strLang
            org3rdid:(NSString *)strOrg3rdid
             uq3rdid:(NSString *)strUq3rdid
              market:(NSString *)strMarket
      isExistFDTUser:(NSNumber *)numIsExistFDTUser
               genId:(BOOL)genId;
@end
