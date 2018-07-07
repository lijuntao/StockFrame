//
//  AccountSetting.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "AccountSetting.h"

@implementation AccountSetting
@synthesize dict = _dict;

- (id)initWithUser:(NSString *)strUser
           account:(NSString *)strAccount
          stoploss:(NSDecimalNumber *)numStopLoss
        defaultQty:(NSDecimalNumber *)numDefaultQty
       defaultQty2:(NSString *)strJSONDefaultQty
      trailingStop:(NSDecimalNumber *)numTrailingStop
       tradingType:(NSNumber *)numTradingType
     dailyStoploss:(NSDecimalNumber *)numDailyStopLoss
   accountStoploss:(NSDecimalNumber *)numAccStopLoss
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_AccountSetting;
        self.seq = [JPacketSendBase getSeqIncreased];
        _user = strUser;
        _account = strAccount;
        _stoploss = numStopLoss;
        _defq = numDefaultQty;
        _trailingStop = numTrailingStop;
        _tradingType = numTradingType;
        _daily_sl = numDailyStopLoss;
        _account_sl = numAccStopLoss;
        _defq2 = strJSONDefaultQty;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strUser)
            [dict setObject:strUser forKey:@(3)];
        
        if (strAccount)
            [dict setObject:strAccount forKey:@(4)];
        
        if (numStopLoss)
            [dict setObject:numStopLoss forKey:@(5)];
        
        if (numDefaultQty)
            [dict setObject:numDefaultQty forKey:@(6)];
        
        if (numTrailingStop)
            [dict setObject:numTrailingStop forKey:@(8)];
        
        if (numTradingType)
            [dict setObject:numTradingType forKey:@(9)];
        
        if (numDailyStopLoss)
            [dict setObject:numDailyStopLoss forKey:@(10)];
        
        if (numAccStopLoss)
            [dict setObject:numAccStopLoss forKey:@(11)];
        
        if (strJSONDefaultQty)
            [dict setObject:strJSONDefaultQty forKey:@(12)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: AccountSetting(%d)\n\t", EnumPacketPT_AccountSetting];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"user: %@\n\t", _user];
    [strRet appendFormat:@"account: %@\n\t", _account];
    if (_stoploss)
        [strRet appendFormat:@"stoploss: %@\n\t", _stoploss];
    if (_defq)
        [strRet appendFormat:@"defq: %@\n\t", _defq];
    if (_trailingStop)
        [strRet appendFormat:@"trailingStop: %@\n\t", _trailingStop];
    if (_tradingType)
        [strRet appendFormat:@"trading_type: %@\n\t", _tradingType];
    if (_daily_sl)
        [strRet appendFormat:@"daily_sl: %@\n\t", _daily_sl];
    if (_account_sl)
        [strRet appendFormat:@"account_sl: %@\n\t", _account_sl];
    if (_defq2)
        [strRet appendFormat:@"defq2: %@\n\t", _defq2];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
