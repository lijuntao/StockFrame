//
//  UnionCreate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/1/27.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "CreateUser.h"

@interface UnionCreate : CreateUser

@property (nonatomic, strong, readonly) NSString *phone_country;

- (id)initWithUserID:(NSString *)strUserID
            password:(NSString *)strPwd
               email:(NSString *)strEmail
               phone:(NSString *)strPhone
             country:(NSString *)strCountry
                lang:(NSString *)strLanguage
               genId:(BOOL)genId
       phone_country:(NSString *)phone_country;

@end
