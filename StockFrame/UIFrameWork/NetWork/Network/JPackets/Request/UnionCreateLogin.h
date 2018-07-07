//
//  UnionCreateLogin.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/1/27.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "UserCreateLogin.h"

@interface UnionCreateLogin : UserCreateLogin
@property (nonatomic, strong, readonly) NSString *phone_country;

- (id)initWithWithUnionID:(NSString *)unionID
                   openID:(NSString *)openID
                    email:(NSString *)strEmail
                    phone:(NSString *)strPhone
                    uType:(EnumUserRoleType)uType
                  country:(NSString *)strCountry
                     lang:(NSString *)strLanguage
            phone_country:(NSString *)phone_country;;

@end
