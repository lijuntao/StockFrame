//
//  UserChangePassword.h
//  MasterDataManager
//
//  Created by 姚晨峰 on 16/8/29.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"
/**
 用户更改密码
 */
@interface UserChangePassword : JPacketSendBase
//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *phone;
@property (nonatomic, strong, readonly) NSString *orgpwd;
@property (nonatomic, strong, readonly) NSString *pwd;
@property (nonatomic, assign, readonly) BOOL isVerified;

- (id)initWithUserID:(NSString *)phone
              oriPwd:(NSString *)strOriPwd
              newPwd:(NSString *)strNewPwd
            verified:(BOOL)isVerified;
@end
