//
//  UserMappingDetach.m
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/5/29.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "UserMappingDetach.h"

@implementation UserMappingDetach

@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)strUserID
                 pwd:(NSString *)strPWD
             user3rd:(NSString *)str3rdUserID
              market:(NSString *)strMarket
            language:(NSString *)strLanguage
                txid:(NSString *)strTXID
           is_attach:(BOOL)is_attach
               utype:(EnumUserRoleType)utype
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_UserMappingDetach;
        self.seq = [JPacketSendBase getSeqIncreased];
        _user = strUserID;
        _pwd = strPWD;
        _user_3rd = str3rdUserID;
        _market = strMarket;
        _language = strLanguage;
        _txid = strTXID;
        _is_attach = is_attach;
        _utype = utype;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:strTXID forKey:@(3)];
        [dict setObject:strUserID forKey:@(4)];
        if (strPWD){
            [dict setObject:strPWD forKey:@(5)];
        }
        [dict setObject:str3rdUserID forKey:@(6)];
        [dict setObject:strMarket forKey:@(7)];
        [dict setObject:strLanguage forKey:@(8)];
        [dict setObject:@(_is_attach) forKey:@(9)];
        [dict setObject:@(_utype) forKey:@(10)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: UserMappingDetach (%d)\n\t", EnumPacketPT_UserMappingDetach];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendFormat:@"user: %@\n\t", _user];
    if (_pwd) {
        [strRet appendFormat:@"pwd: %@\n\t", _pwd];
    }
    [strRet appendFormat:@"user_3rd: %@\n\t", _user_3rd];
    [strRet appendFormat:@"market: %@\n\t", _market];
    [strRet appendFormat:@"language: %@\n\t", _language];
    [strRet appendFormat:@"is_attach: %d\n\t", _is_attach];
    [strRet appendFormat:@"utype: %d\n\t", _utype];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
