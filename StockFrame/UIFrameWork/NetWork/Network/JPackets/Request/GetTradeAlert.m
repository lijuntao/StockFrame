//
//  GetTradeAlert.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "GetTradeAlert.h"

@implementation GetTradeAlert
@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)strUser
                txid:(NSString *)strTXID
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_GetTradeAlert;
        self.seq = [JPacketSendBase getSeqIncreased];
        _user = strUser;
        _txid = strTXID;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        [dict setObject:strUser forKey:@(3)];
        [dict setObject:strTXID forKey:@(4)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetTradeAlert(%d)\n\t", EnumPacketPT_GetTradeAlert];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"user: %@\n\t", _user];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
