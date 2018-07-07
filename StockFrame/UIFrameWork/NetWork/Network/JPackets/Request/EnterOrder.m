//
//  EnterOrder.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "EnterOrder.h"

@implementation EnterOrder
@synthesize dict = _dict;

- (id)initWithAccount:(NSString *)strAccount
             symbolID:(NSString *)strSymbolID
                 side:(EnumOrderSide)side
                otype:(EnumOrderType)otype
             strategy:(EnumOrderStrategy)strategy
                price:(NSDecimalNumber *)numPrice
       strategyPrice1:(NSDecimalNumber *)numStrategyPrice1
                  qty:(NSDecimalNumber *)numQty
                 txid:(NSString *)strTXID
               reason:(EnumEnterOrderReason)reason
               behalf:(NSString *)behalf
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_EnterOrder;
        self.seq = [JPacketSendBase getSeqIncreased];
        _account = strAccount;
        _sym = strSymbolID;
        _side = side;
        _otype = otype;
        _strategy = strategy;
        _price = numPrice;
        _qty = numQty;
        _strategyPrice1 = numStrategyPrice1;
        _txid = strTXID;
        _reason = reason;
        _behalf = behalf;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strAccount)
            [dict setObject:strAccount forKey:@(3)];
        
        if (strSymbolID)
            [dict setObject:strSymbolID forKey:@(4)];
        
        [dict setObject:@(side) forKey:@(5)];
        [dict setObject:@(otype) forKey:@(6)];
        
        if (numPrice)
            [dict setObject:numPrice forKey:@(7)];
        
        if (numQty)
            [dict setObject:numQty forKey:@(8)];
        
        [dict setObject:@(strategy) forKey:@(9)];
        
        if (numStrategyPrice1)
            [dict setObject:numStrategyPrice1 forKey:@(10)];
        
        [dict setObject:strTXID forKey:@(11)];
        [dict setObject:@(reason) forKey:@(13)];
        
        if (behalf)
            [dict setObject:behalf forKey:@(14)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: EnterOrder (%d)\n\t", EnumPacketPT_EnterOrder];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"account: %@\n\t", _account];
    [strRet appendFormat:@"sym: %@\n\t", _sym];
    [strRet appendFormat:@"side: %d\n\t", _side];
    [strRet appendFormat:@"otype: %d\n\t", _otype];
    if (_price)
        [strRet appendFormat:@"price: %@\n\t", _price];
    [strRet appendFormat:@"qty: %@\n\t", _qty];
    [strRet appendFormat:@"strategy: %d\n\t", _strategy];
    if (_strategyPrice1)
        [strRet appendFormat:@"strategy_prc1: %@\n\t", _strategyPrice1];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendFormat:@"reason: %d\n\t", _reason];
    [strRet appendFormat:@"behalf: %@\n\t", _behalf];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
