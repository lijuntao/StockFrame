//
//  WmUnionLogin.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/13.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmUnionLogin.h"

@implementation WmUnionLogin

@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)strUserID
            password:(NSString *)strPwd
             country:(NSString *)strCountry
            language:(NSString *)strLang
           loginType:(EnumLoginType)loginType
              device:(NSString *)device
     device_verified:(BOOL)device_verified
              client:(NSInteger) client{
    
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_WmUnionLogin;
        self.seq = [JPacketSendBase getSeqIncreased];
        self.waitingPacket = EnumPacketPT_UnionTokenUpdate;
        
        _user = strUserID;
        _pwd = strPwd;
        _country = strCountry;
        _language = strLang;
        _login_type = loginType;
        _device = device;
        _device_verified = device_verified;
        _client = client;
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:strUserID forKey:@(3)];
        [dict setObject:strPwd forKey:@(4)];
        [dict setObject:strCountry forKey:@(5)];
        [dict setObject:strLang forKey:@(6)];
        [dict setObject:@(loginType) forKey:@(7)];
        [dict setObject:device forKey:@(8)];
        [dict setObject:@(device_verified) forKey:@(9)];
        [dict setObject:@(_client) forKey:@(10)];
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: WmUnionLogin(%d)\n\t", EnumPacketPT_WmUnionLogin];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"user: %@\n\t", _user];
    [strRet appendFormat:@"pwd: %@\n\t", _pwd];
    [strRet appendFormat:@"country: %@\n\t", _country];
    [strRet appendFormat:@"language: %@\n\t", _language];
    [strRet appendFormat:@"login_type: %d\n\t", _login_type];
    [strRet appendFormat:@"device: %@\n\t", _device];
    [strRet appendFormat:@"device_verified: %ld\n\t", (long)_device_verified];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
