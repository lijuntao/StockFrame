//
//  GetOrder.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "GetOrder.h"

@implementation GetOrder

@synthesize dict = _dict;

- (id)initWithAccount:(NSString *)strAccount
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_GetOrder;
        self.seq = [JPacketSendBase getSeqIncreased];
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        _account = strAccount;
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
    [strRet appendFormat:@"pt: GetOrder (%d)\n\t", EnumPacketPT_GetOrder];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    if (_account)
        [strRet appendFormat:@"account: %@\n\t", _account];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
