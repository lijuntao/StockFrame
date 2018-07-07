//
//  GetUserMapping.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "GetUserMapping.h"

@implementation GetUserMapping

@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)strUserID
             user3rd:(NSString *)str3rdUserID
              market:(NSString *)strMarket
            language:(NSString *)strLanguage
                txid:(NSString *)strTXID
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_GetUserMapping;
        self.seq = [JPacketSendBase getSeqIncreased];
         _user = strUserID;
        _user_3rd = str3rdUserID;
        _market = strMarket;
        _language = strLanguage;
        _txid = strTXID;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        [dict setObject:strTXID forKey:@(3)];
        if (strUserID)
            [dict setObject:strUserID forKey:@(4)];
        [dict setObject:str3rdUserID forKey:@(5)];
        [dict setObject:strMarket forKey:@(6)];
        [dict setObject:strLanguage forKey:@(7)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetUserMapping (%d)\n\t", EnumPacketPT_GetUserMapping];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    if (_user)
        [strRet appendFormat:@"user: %@\n\t", _user];
    [strRet appendFormat:@"user_3rd: %@\n\t", _user_3rd];
    [strRet appendFormat:@"market: %@\n\t", _market];
    [strRet appendFormat:@"language: %@\n\t", _language];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
