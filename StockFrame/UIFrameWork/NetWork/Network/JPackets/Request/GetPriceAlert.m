//
//  GetPriceAlert.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "GetPriceAlert.h"

@implementation GetPriceAlert
@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)strUser
                type:(EnumQueryPriceAlertType)type
                txid:(NSString *)strTXID
               token:(NSString *)token
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_GetPriceAlert;
        self.seq = [JPacketSendBase getSeqIncreased];
        _user = strUser;
        _type = type;
        _txid = strTXID;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        [dict setObject:strUser forKey:@(3)];
        [dict setObject:@(type) forKey:@(4)];
        [dict setObject:strTXID forKey:@(5)];
        if (token){
            [dict setObject:token forKey:@(7)];
        }
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetPriceAlert(%d)\n\t", EnumPacketPT_GetPriceAlert];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"user: %@\n\t", _user];
    [strRet appendFormat:@"type: %d\n\t", _type];
    [strRet appendFormat:@"txid: %@\n\t", _txid]; 
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
