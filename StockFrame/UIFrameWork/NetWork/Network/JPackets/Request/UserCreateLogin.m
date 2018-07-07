//
//  UserCreateLogin.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "UserCreateLogin.h"

@implementation UserCreateLogin

@synthesize dict = _dict;

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
               genId:(BOOL)genId
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_UserCreateLogin;
        self.seq = [JPacketSendBase getSeqIncreased];
        _user = strUserID;
        _pwd = strPwd;
        _email = strEmail;
        _phone = strPhone;
        _utype = type;
        _country = strCountry;
        _parseid = strParseID;
        _lang_code = strLang;
        _org3rdid = strOrg3rdid;
        _uq3rdid = strUq3rdid;
        _market = strMarket;
        _is_exist_user = numIsExistFDTUser;
        _genId = genId;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strUserID)
            [dict setObject:strUserID forKey:@(3)];
        if (strPwd)
            [dict setObject:strPwd forKey:@(4)];
        [dict setObject:strEmail forKey:@(5)];
        [dict setObject:strPhone forKey:@(6)];
        [dict setObject:@(type) forKey:@(7)];
        [dict setObject:strCountry forKey:@(8)];
        [dict setObject:strParseID forKey:@(9)];
        [dict setObject:strLang forKey:@(10)];
        if (strOrg3rdid)
            [dict setObject:strOrg3rdid forKey:@(11)];
        if (strUq3rdid)
            [dict setObject:strUq3rdid forKey:@(12)];
        [dict setObject:strMarket forKey:@(13)];
        
        if (numIsExistFDTUser)
            [dict setObject:numIsExistFDTUser forKey:@(14)];
        [dict setObject:@(genId) forKey:@(15)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: UserCreateLogin(%d)\n\t", EnumPacketPT_UserCreateLogin];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    if (_user)
        [strRet appendFormat:@"user: %@\n\t", _user];
    if (_pwd)
        [strRet appendFormat:@"pwd: %@\n\t", _pwd];
    [strRet appendFormat:@"email: %@\n\t", _email];
    [strRet appendFormat:@"phone: %@\n\t", _phone];
    [strRet appendFormat:@"utype: %d\n\t", _utype];
    [strRet appendFormat:@"country: %@\n\t", _country];
    [strRet appendFormat:@"parseid: %@\n\t", _parseid];
    [strRet appendFormat:@"lang_code: %@\n\t", _lang_code];
    if (_org3rdid)
        [strRet appendFormat:@"org3rdid: %@\n\t", _org3rdid];
    if (_uq3rdid)
        [strRet appendFormat:@"uq3rdid: %@\n\t", _uq3rdid];
    [strRet appendFormat:@"market: %@\n\t", _market];
    if (_is_exist_user)
        [strRet appendFormat:@"is_exist_user: %@\n\t", _is_exist_user];
    [strRet appendFormat:@"gen_id: %@\n\t", @(_genId)];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
