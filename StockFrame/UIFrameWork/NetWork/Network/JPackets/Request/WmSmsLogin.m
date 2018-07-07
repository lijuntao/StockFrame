//
//  WmSmsLogin.m
//  MasterDataManager
//
//  Created by 姚晨峰 on 2017/5/15.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "WmSmsLogin.h"

@implementation WmSmsLogin
@synthesize dict = _dict;

- (id)initWithPhone:(NSString *)phone
           sms_code:(NSString *)sms_code
            country:(NSString *)strCountry
           language:(NSString *)strLang
             device:(NSString *)device
    appver:(NSString *)appver
             client:(NSInteger) client{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_WmSmsLogin;
        self.seq = [JPacketSendBase getSeqIncreased];
        self.waitingPacket = EnumPacketPT_UnionTokenUpdate;
        
        _phone = phone;
        _sms_code= sms_code;
        _country = strCountry;
        _language = strLang;
        _device = device;
        _app_ver = appver;
        _client = client;
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:phone forKey:@(3)];
        [dict setObject:sms_code forKey:@(4)];
        [dict setObject:strCountry forKey:@(5)];
        [dict setObject:strLang forKey:@(6)];
        [dict setObject:device forKey:@(7)];
        [dict setObject:@(client) forKey:@(8)];
        [dict setObject:_app_ver forKey:@(9)];
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
    [strRet appendFormat:@"phone: %@\n\t", _phone];
    [strRet appendFormat:@"sms_code: %@\n\t", _sms_code];
    [strRet appendFormat:@"country: %@\n\t", _country];
    [strRet appendFormat:@"language: %@\n\t", _language];
    [strRet appendFormat:@"device: %@\n\t", _device];
    [strRet appendFormat:@"appver: %@\n\t", _app_ver];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
