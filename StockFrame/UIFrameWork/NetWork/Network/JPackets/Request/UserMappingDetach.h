//
//  UserMappingDetach.h
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/5/29.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface UserMappingDetach : JPacketSendBase

@property (nonatomic, strong, readonly) NSString *txid;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, strong, readonly) NSString *pwd;
@property (nonatomic, strong, readonly) NSString *user_3rd;
@property (nonatomic, strong, readonly) NSString *market;
@property (nonatomic, strong, readonly) NSString *language;
@property (nonatomic, assign) BOOL is_attach;
@property (nonatomic, assign) EnumUserRoleType utype;

- (id)initWithUserID:(NSString *)strUserID
                 pwd:(NSString *)strPWD
             user3rd:(NSString *)str3rdUserID
              market:(NSString *)strMarket
            language:(NSString *)strLanguage
                txid:(NSString *)strTXID
           is_attach:(BOOL)is_attach
               utype:(EnumUserRoleType)utype;

@end
