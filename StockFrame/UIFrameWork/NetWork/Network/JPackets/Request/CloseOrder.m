//
//  CloseOrder.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "CloseOrder.h"

@implementation CloseOrder
@synthesize dict = _dict;

- (id)initWithAccount:(NSString *)strAccount
             symbolID:(NSString *)strSymbolID
                 txid:(NSString *)strTXID
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_CloseOrder;
        self.seq = [JPacketSendBase getSeqIncreased];
        _account = strAccount;
        _symbol = strSymbolID;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strAccount)
            [dict setObject:strAccount forKey:@(3)];
        
        if (strSymbolID)
            [dict setObject:strSymbolID forKey:@(4)];
        
        [dict setObject:strTXID forKey:@(5)];
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: CloseOrder (%d)\n\t", EnumPacketPT_CloseOrder];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"account: %@\n\t", _account];
    [strRet appendFormat:@"symbol: %@\n\t", _symbol];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
