//
//  AmendOrder.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface AmendOrder : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *account;
@property (nonatomic, strong, readonly) NSString *orderID;
@property (nonatomic, strong, readonly) NSDecimalNumber *price;
@property (nonatomic, strong, readonly) NSDecimalNumber *strategyPrice1;
@property (nonatomic, strong, readonly) NSDecimalNumber *quantity;
@property (nonatomic, strong, readonly) NSString *txid;

- (id)initWithAccount:(NSString *)strAccount
              orderID:(NSString *)strOrerID
                price:(NSDecimalNumber *)numPrice
       strategyPrice1:(NSDecimalNumber *)numStrategyPrice1
             quantity:(NSDecimalNumber *)numQuantity
                 txid:(NSString *)strTXID;
@end
