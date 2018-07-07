//
//  WmAmendOrder.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmAmendOrder.h"

@implementation WmAmendOrder
@synthesize dict = _dict;

- (id)initWithId:(NSString *)Id
            txid:(NSString *)txid
           price:(NSDecimalNumber *)price
             qty:(NSDecimalNumber *)qty {
    
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_WmAmendOrder;
        self.seq = [JPacketSendBase getSeqIncreased];
        _Id = Id;
        _txid = txid;
        _price = price;
        _qty = qty;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:self.Id forKey:@(3)];
        [dict setObject:self.txid forKey:@(4)];
        [dict setObject:self.price forKey:@(5)];
        [dict setObject:self.qty forKey:@(6)];
        
        _dict = (NSDictionary *)dict;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: WmAmendOrder(%d)\n\t", EnumPacketPT_WmAmendOrder];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"Id: %@\n\t", _Id];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendFormat:@"price: %@\n\t", _price];
    [strRet appendFormat:@"qty: %@\n\t", _qty];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
