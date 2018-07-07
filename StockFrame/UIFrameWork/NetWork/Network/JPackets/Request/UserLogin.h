//
//  UserLogin.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h" 

@interface UserLogin : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, strong, readonly) NSString *pwd;
@property (nonatomic, strong, readonly) NSString *parseid;
@property (nonatomic, strong, readonly) NSString *country;
@property (nonatomic, strong, readonly) NSString *language;
@property (nonatomic, assign, readonly) EnumLoginType login_type;

- (id)initWithUserID:(NSString *)strUserID
            password:(NSString *)strPwd
             parseID:(NSString *)strParseID
             country:(NSString *)strCountry
            language:(NSString *)strLang
           loginType:(EnumLoginType)loginType;
@end
