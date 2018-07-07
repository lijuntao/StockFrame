//
//  UnionCreate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/1/27.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "UnionCreate.h"

@implementation UnionCreate

@synthesize dict = _dict, user = _user, pwd = _pwd, phone = _phone, uType = _uType, country = _country, langCode = _langCode, genId = _genId,email = _email;

- (id)initWithUserID:(NSString *)strUserID
            password:(NSString *)strPwd
               email:(NSString *)strEmail
               phone:(NSString *)strPhone
             country:(NSString *)strCountry
                lang:(NSString *)strLanguage
               genId:(BOOL)genId
       phone_country:(NSString *)phone_country
{
    self = [super initWithUserID:strUserID password:strPwd email:strEmail phone:strPhone country:strCountry lang:strLanguage genId:genId];
    
    if (self) {
        self.pt = EnumPacketPT_UnionCreateUser;
        self.seq = [JPacketSendBase getSeqIncreased];
        _user = strUserID;
        _pwd = strPwd;
        _email = strEmail;
        _phone = strPhone;
        _uType = EnumUserRoleType_Normal;
        _country = strCountry;
        _langCode = strLanguage;
        _genId = genId;
        _phone_country = phone_country;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strUserID)
        {
            [dict setObject:strUserID forKey:@(3)];
        }
        
        [dict setObject:strPwd forKey:@(4)];
        [dict setObject:strEmail forKey:@(5)];
        [dict setObject:strPhone forKey:@(6)];
        [dict setObject:@(_uType) forKey:@(7)];
        [dict setObject:strCountry forKey:@(8)];
        [dict setObject:strLanguage forKey:@(9)];
        [dict setObject:@(genId) forKey:@(10)];
        
        if (_phone_country) {
            [dict setObject:_phone_country forKey:@(11)];
        }
        _dict = (NSDictionary *)dict;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: UnionCreateUser (%d)\n\t", EnumPacketPT_UnionCreateUser];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"user: %@\n\t", self.user];
    [strRet appendFormat:@"pwd: %@\n\t", self.pwd];
    [strRet appendFormat:@"email: %@\n\t", self.email];
    [strRet appendFormat:@"phone: %@\n\t", self.phone];
    [strRet appendFormat:@"utype: %d\n\t", self.uType];
    [strRet appendFormat:@"country: %@\n\t", self.country];
    [strRet appendFormat:@"langcode: %@\n\t", self.langCode];
    [strRet appendFormat:@"genId: %@\n\t", @(self.genId)];
    [strRet appendFormat:@"phone_country: %@\n\t", self.phone_country];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
