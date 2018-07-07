//
//  ChangeUserPassword.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface ChangeUserPassword : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, strong, readonly) NSString *orgpwd;
@property (nonatomic, strong, readonly) NSString *pwd;
@property (nonatomic, assign, readonly) BOOL isVerified;

- (id)initWithUserID:(NSString *)strUserID
              oriPwd:(NSString *)strOriPwd
              newPwd:(NSString *)strNewPwd
            verified:(BOOL)isVerified;
@end
