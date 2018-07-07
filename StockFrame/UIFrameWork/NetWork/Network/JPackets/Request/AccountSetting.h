//
//  AccountSetting.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface AccountSetting : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *user;
@property (nonatomic, strong, readonly) NSString *account;
@property (nonatomic, strong, readonly) NSDecimalNumber *stoploss;
@property (nonatomic, strong, readonly) NSDecimalNumber *defq;
@property (nonatomic, strong, readonly) NSString *defq2;
@property (nonatomic, strong, readonly) NSDecimalNumber *trailingStop;
@property (nonatomic, strong, readonly) NSNumber *tradingType;
@property (nonatomic, strong, readonly) NSDecimalNumber *daily_sl;
@property (nonatomic, strong, readonly) NSDecimalNumber *account_sl;

- (id)initWithUser:(NSString *)strUser
           account:(NSString *)strAccount
          stoploss:(NSDecimalNumber *)numStopLoss
        defaultQty:(NSDecimalNumber *)numDefaultQty
        defaultQty2:(NSString *)strJSONDefaultQty
      trailingStop:(NSDecimalNumber *)numTrailingStop
       tradingType:(NSNumber *)numTradingType
     dailyStoploss:(NSDecimalNumber *)numDailyStopLoss
   accountStoploss:(NSDecimalNumber *)numAccStopLoss;
@end
