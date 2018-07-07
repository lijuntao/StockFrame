//
//  UseCoinPacket.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/10/1.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "UseCoinPacket.h"

@implementation UseCoinPacket
@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)user
             feautre:(EnumCoinFeature)feautre
               quantity:(NSNumber *)quantity
         auto_expand:(NSNumber *)auto_expand
                txid:(NSString *)strTXID
              market:(NSString *)market
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_UseCoin;
        self.seq = [JPacketSendBase getSeqIncreased];
        _user = user;
        _feautre = feautre;
        _quantity = quantity;
        _auto_expand = auto_expand;
        _txid = strTXID;
        _market = market;

        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:_txid forKey:@(3)];
        
        [dict setObject:@(_feautre) forKey:@(4)];
        [dict setObject:quantity forKey:@(5)];
        [dict setObject:auto_expand forKey:@(6)];
        [dict setObject:user forKey:@(7)];
        [dict setObject:market forKey:@(8)];
        _dict = (NSDictionary *)dict;
    }
    return self;
}
- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: UseCoinPacket(%d)\n\t", self.pt];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"user: %@\n\t", _user];
    [strRet appendFormat:@"feautre: %ld\n\t", (long)_feautre];
    [strRet appendFormat:@"quantity: %@\n\t", _quantity];
    [strRet appendFormat:@"auto_expand: %@\n\t", _auto_expand];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendFormat:@"market: %@\n\t", _market];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
