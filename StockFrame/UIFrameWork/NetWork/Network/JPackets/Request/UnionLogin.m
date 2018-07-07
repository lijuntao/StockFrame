//
//  UnionLogin.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/1/27.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "UnionLogin.h"

@implementation UnionLogin

@synthesize dict = _dict,user = _user,pwd = _pwd,country = _country,language = _language,login_type = _login_type;

- (id)initWithUserID:(NSString *)strUserID
            password:(NSString *)strPwd
             country:(NSString *)strCountry
            language:(NSString *)strLang
           loginType:(EnumLoginType)loginType
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_UnionLogin;
        self.seq = [JPacketSendBase getSeqIncreased];
        
        _user = strUserID;
        _pwd = strPwd;
        _country = strCountry;
        _language = strLang;
        _login_type = loginType;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        [dict setObject:strUserID forKey:@(3)];
        [dict setObject:strPwd forKey:@(4)];
        [dict setObject:strCountry forKey:@(5)];
        [dict setObject:strLang forKey:@(6)];
        [dict setObject:@(loginType) forKey:@(7)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}
- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: UnionLogin(%d)\n\t", EnumPacketPT_UnionLogin];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"user: %@\n\t", _user];
    [strRet appendFormat:@"pwd: %@\n\t", _pwd];
    [strRet appendFormat:@"country: %@\n\t", _country];
    [strRet appendFormat:@"language: %@\n\t", _language];
    [strRet appendFormat:@"login_type: %d\n\t", _login_type];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
