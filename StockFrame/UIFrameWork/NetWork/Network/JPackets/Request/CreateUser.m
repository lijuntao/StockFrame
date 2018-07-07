//
//  CreateUser.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "CreateUser.h"

@implementation CreateUser

@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)strUserID
            password:(NSString *)strPwd
               email:(NSString *)strEmail
               phone:(NSString *)strPhone
             country:(NSString *)strCountry
                lang:(NSString *)strLanguage
               genId:(BOOL)genId
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_CreateUser;
        self.seq = [JPacketSendBase getSeqIncreased];
        _user = strUserID;
        _pwd = strPwd;
        _email = strEmail;
        _phone = strPhone;
        _uType = EnumUserRoleType_Normal;
        _country = strCountry;
        _langCode = strLanguage;
        _genId = genId;
        
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
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: CreateUser (%d)\n\t", EnumPacketPT_CreateUser];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"user: %@\n\t", _user];
    [strRet appendFormat:@"pwd: %@\n\t", _pwd];
    [strRet appendFormat:@"email: %@\n\t", _email];
    [strRet appendFormat:@"phone: %@\n\t", _phone];
    [strRet appendFormat:@"utype: %d\n\t", _uType];
    [strRet appendFormat:@"country: %@\n\t", _country];
    [strRet appendFormat:@"langcode: %@\n\t", _langCode];
    [strRet appendFormat:@"genId: %@\n\t", @(_genId)];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
