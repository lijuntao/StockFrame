//
//  AccountReset.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "AccountReset.h"

@implementation AccountReset

@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)strUserID
             account:(NSString *)strAccount
              market:(NSString *)strMarket
              coinid:(NSString *)strCoinID
                txid:(NSString *)strTXID
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_AccountReset;
        self.seq = [JPacketSendBase getSeqIncreased];
        _userid = strUserID;
        _account = strAccount;
        _market = strMarket;
        _coinid = strCoinID;
        _txid = strTXID;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        [dict setObject:strTXID forKey:@(3)];
        [dict setObject:strUserID forKey:@(4)];
        [dict setObject:strAccount forKey:@(5)];
        [dict setObject:strMarket forKey:@(6)];
        [dict setObject:strCoinID forKey:@(7)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: AccountReset (%d)\n\t", EnumPacketPT_AccountReset];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendFormat:@"userid: %@\n\t", _userid];
    [strRet appendFormat:@"account: %@\n\t", _account];
    [strRet appendFormat:@"market: %@\n\t", _market];
    [strRet appendFormat:@"coinid: %@\n\t", _coinid];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
