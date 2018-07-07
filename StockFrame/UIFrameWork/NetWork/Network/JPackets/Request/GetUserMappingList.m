//
//  GetUserMappingList.m
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/6/4.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "GetUserMappingList.h"

@implementation GetUserMappingList

@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)strUserID
              market:(NSString *)strMarket
            language:(NSString *)strLanguage
                txid:(NSString *)strTXID
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_GetUserMappingList;
        self.seq = [JPacketSendBase getSeqIncreased];
        _user = strUserID;
        _market = strMarket;
        _language = strLanguage;
        _txid = strTXID;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:strTXID forKey:@(3)];
        [dict setObject:strUserID forKey:@(4)];
        [dict setObject:strMarket forKey:@(5)];
        [dict setObject:strLanguage forKey:@(6)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetUserMappingList (%d)\n\t", EnumPacketPT_GetUserMappingList];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendFormat:@"user: %@\n\t", _user];
    [strRet appendFormat:@"market: %@\n\t", _market];
    [strRet appendFormat:@"language: %@\n\t", _language];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
