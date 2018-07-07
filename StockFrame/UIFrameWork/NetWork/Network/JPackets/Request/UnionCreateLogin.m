//
//  UnionCreateLogin.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/1/27.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "UnionCreateLogin.h"

@implementation UnionCreateLogin

@synthesize phone = _phone, email = _email, utype = _utype, country = _country, lang_code = _lang_code, org3rdid = _org3rdid, uq3rdid = _uq3rdid, dict = _dict;

- (id)initWithWithUnionID:(NSString *)unionID
                   openID:(NSString *)openID
                    email:(NSString *)strEmail
                    phone:(NSString *)strPhone
                    uType:(EnumUserRoleType)uType
                  country:(NSString *)strCountry
                     lang:(NSString *)strLanguage
            phone_country:(NSString *)phone_country;
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_UnionCreateLogin;
        self.seq = [JPacketSendBase getSeqIncreased];

        _email = strEmail;
        _phone = strPhone;
        _utype = uType;
        _country = strCountry;
        _lang_code = strLanguage;
        _org3rdid = openID;
        _uq3rdid = unionID;
        _phone_country = phone_country;
        
        
        /*
         email
         5
         String
         所要建立的使用者eMail，沒有填空字串
         phone
         6
         String
         所要建立的使用者phone，沒有填空字串
         */
        if (!_phone) {
            _phone = @"";
        }
        if (!_email) {
            _email = @"";
        }
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        

        if (_uq3rdid)
            [dict setObject:_uq3rdid forKey:@(3)];

        if (_org3rdid) {
            [dict setObject:_org3rdid forKey:@(4)];
        }
        
        
        if (_email) {
            [dict setObject:_email forKey:@(5)];
        }
        
        if (_phone) {
            [dict setObject:_phone forKey:@(6)];            
        }

        [dict setObject:@(_utype) forKey:@(7)];
        [dict setObject:_country forKey:@(8)];
        [dict setObject:_lang_code forKey:@(9)];
        
        if (phone_country)
            [dict setObject:_phone_country forKey:@(10)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: UnionCreateLogin(%d)\n\t", EnumPacketPT_UnionCreateLogin];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"email: %@\n\t", _email];
    [strRet appendFormat:@"phone: %@\n\t", _phone];
    [strRet appendFormat:@"utype: %d\n\t", _utype];
    [strRet appendFormat:@"country: %@\n\t", _country];
    [strRet appendFormat:@"lang_code: %@\n\t", _lang_code];
    [strRet appendFormat:@"org3rdid: %@\n\t", _org3rdid];
    if (_uq3rdid)
        [strRet appendFormat:@"uq3rdid: %@\n\t", _uq3rdid];

    if (_phone_country)
        [strRet appendFormat:@"phone_country: %@\n\t", _phone_country];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
