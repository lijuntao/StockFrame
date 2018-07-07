//
//  UnionLogin.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/1/27.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "UserLogin.h"

@interface UnionLogin : UserLogin
- (id)initWithUserID:(NSString *)strUserID
            password:(NSString *)strPwd
             country:(NSString *)strCountry
            language:(NSString *)strLang
           loginType:(EnumLoginType)loginType;
@end
