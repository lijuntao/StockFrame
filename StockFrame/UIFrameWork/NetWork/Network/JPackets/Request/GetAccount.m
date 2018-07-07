//
//  GetAccount.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "GetAccount.h"

@implementation GetAccount
@synthesize dict = _dict;

- (id)initWithAccount:(NSString *)strAccount
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_GetAccount;
        self.seq = [JPacketSendBase getSeqIncreased];
        _account = strAccount;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strAccount)
            [dict setObject:strAccount forKey:@(3)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetAccount (%d)\n\t", EnumPacketPT_GetAccount];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"account: %@\n\t", _account];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
