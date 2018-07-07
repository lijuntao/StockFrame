//
//  GetEmailUsage.m
//  MasterDataManager
//
//  Created by jiangnan on 15/11/24.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "GetEmailUsage.h"

@implementation GetEmailUsage

@synthesize dict = _dict;

-(instancetype)initWithTxid:(NSString *)txid email:(NSString*)email
{
    self = [super init];
    if (self) {
        self.pt = EnumPacketPT_GetEmailUsage;
        self.seq = [JPacketSendBase getSeqIncreased];
        _txid = txid;
        _email = email;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        [dict setObject:txid forKey:@(3)];
        [dict setObject:email forKey:@(4)];
        
        _dict = (NSDictionary *)dict;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetEmailUsage(%d)\n\t", EnumPacketPT_GetPhoneUsage];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendFormat:@"email: %@\n\t", _email];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
