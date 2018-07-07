//
//  AmendOrder.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "AmendOrder.h"

@implementation AmendOrder
@synthesize dict = _dict;

- (id)initWithAccount:(NSString *)strAccount
              orderID:(NSString *)strOrerID
                price:(NSDecimalNumber *)numPrice
       strategyPrice1:(NSDecimalNumber *)numStrategyPrice1
             quantity:(NSDecimalNumber *)numQuantity
                 txid:(NSString *)strTXID
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_AmendOrder;
        self.seq = [JPacketSendBase getSeqIncreased];
        _account = strAccount;
        _orderID = strOrerID;
        _price = numPrice;
        _strategyPrice1 = numStrategyPrice1;
        _quantity = numQuantity;
        _txid = strTXID;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strAccount)
            [dict setObject:strAccount forKey:@(3)];
        
        if (strOrerID)
            [dict setObject:strOrerID forKey:@(4)];
        
        if (numPrice)
            [dict setObject:numPrice forKey:@(5)];
        
        if (numQuantity)
            [dict setObject:numQuantity forKey:@(6)];
        
        if (numStrategyPrice1)
            [dict setObject:numStrategyPrice1 forKey:@(7)];
        
        [dict setObject:strTXID forKey:@(8)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: AmendOrder(%d)\n\t", EnumPacketPT_AmendOrder];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"account: %@\n\t", _account];
    [strRet appendFormat:@"id: %@\n\t", _orderID];
    if (_price)
        [strRet appendFormat:@"price: %@\n\t", _price];
    if (_quantity)
        [strRet appendFormat:@"qty: %@\n\t", _quantity];
    if (_strategyPrice1)
        [strRet appendFormat:@"strategy_prc1: %@\n\t", _strategyPrice1];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
