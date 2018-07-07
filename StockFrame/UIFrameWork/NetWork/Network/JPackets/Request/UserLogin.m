//
//  UserLogin.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.rick
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "UserLogin.h"

@implementation UserLogin

@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)strUserID
            password:(NSString *)strPwd
             parseID:(NSString *)strParseID
             country:(NSString *)strCountry
            language:(NSString *)strLang
           loginType:(EnumLoginType)loginType
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_UnionLogin;
        self.seq = [JPacketSendBase getSeqIncreased];
        self.waitingPacket = EnumPacketPT_UserUpdate;
        
        _user = strUserID;
        _pwd = strPwd;
        _parseid = strParseID;
        _country = strCountry;
        _language = strLang;
        _login_type = loginType;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        [dict setObject:strUserID forKey:@(3)];
        [dict setObject:strPwd forKey:@(4)];
        [dict setObject:strParseID forKey:@(5)];
        [dict setObject:strCountry forKey:@(6)];
        [dict setObject:strLang forKey:@(7)];
        [dict setObject:@(loginType) forKey:@(8)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: UserLogin(%d)\n\t", EnumPacketPT_UserLogin];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"user: %@\n\t", _user];
    [strRet appendFormat:@"pwd: %@\n\t", _pwd];
    [strRet appendFormat:@"parseid: %@\n\t", _parseid];
    [strRet appendFormat:@"country: %@\n\t", _country];
    [strRet appendFormat:@"language: %@\n\t", _language];
    [strRet appendFormat:@"login_type: %d\n\t", _login_type];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
