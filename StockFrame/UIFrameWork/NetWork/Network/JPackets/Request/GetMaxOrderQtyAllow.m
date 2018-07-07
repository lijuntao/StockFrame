//
//  GetMaxOrderQtyAllow.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/12/15.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "GetMaxOrderQtyAllow.h"

@implementation GetMaxOrderQtyAllow
@synthesize dict = _dict;


- (id)initWithMarket:(NSString *)market
              userid:(NSString *)userid
             account:(NSString *)account
            symbolid:(NSString *)symbolid
                side:(EnumOrderSide)side
               price:(NSDecimalNumber *)price
               otype:(EnumOrderType)otype
                txid:(NSString *)strTXID
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_GetMaxOrderQtyAllow;
        self.seq = [JPacketSendBase getSeqIncreased];
        _market = market;
        _userid = userid;
        _account = account;
        _symbolid = symbolid;
        _side = side;
        _otype = otype;
        _txid = strTXID;
        _price = price;
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];

        if (market)
            [dict setObject:market forKey:@(3)];
        
        if (userid)
            [dict setObject:userid forKey:@(4)];
        
        if (account)
            [dict setObject:account forKey:@(5)];
        
        if (symbolid)
            [dict setObject:symbolid forKey:@(6)];

        
        [dict setObject:@(side) forKey:@(7)];
        [dict setObject:@(otype) forKey:@(8)];

        if (price) {
            [dict setObject:price forKey:@(9)];
        }
        
        [dict setObject:strTXID forKey:@(10)];

        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetMaxOrderQtyAllow (%d)\n\t", EnumPacketPT_GetMaxOrderQtyAllow];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"market: %@\n\t", _market];
    [strRet appendFormat:@"userid: %@\n\t", _userid];
    [strRet appendFormat:@"account: %@\n\t", _account];
    [strRet appendFormat:@"symbolid: %@\n\t", _symbolid];
    [strRet appendFormat:@"side: %d\n\t", _side];
    [strRet appendFormat:@"price: %@\n\t", _price];
    [strRet appendFormat:@"otype: %d\n\t", _otype];
    [strRet appendFormat:@"txid: %@\n\t", _txid];

    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
