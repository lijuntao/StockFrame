//
//  CancelOrder.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "CancelOrder.h"

@implementation CancelOrder
@synthesize dict = _dict;

- (id)initWithAccount:(NSString *)strAccount
              orderID:(NSString *)strOrerID
                 txid:(NSString *)strTXID
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_CancelOrder;
        self.seq = [JPacketSendBase getSeqIncreased];
        _account = strAccount;
        _orderID = strOrerID;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strAccount)
            [dict setObject:strAccount forKey:@(3)];
        
        if (strOrerID)
            [dict setObject:strOrerID forKey:@(4)];
        
        [dict setObject:strTXID forKey:@(5)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: CancleOrder (%d)\n\t", EnumPacketPT_CancelOrder];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"account: %@\n\t", _account];
    [strRet appendFormat:@"id: %@\n\t", _orderID];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
