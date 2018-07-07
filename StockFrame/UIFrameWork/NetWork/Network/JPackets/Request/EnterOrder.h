//
//  EnterOrder.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface EnterOrder : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSString *account;
@property (nonatomic, strong, readonly) NSString *sym;
@property (nonatomic, assign, readonly) EnumOrderSide side;
@property (nonatomic, assign, readonly) EnumOrderType otype;
@property (nonatomic, strong, readonly) NSDecimalNumber *price;
@property (nonatomic, strong, readonly) NSDecimalNumber *qty;
@property (nonatomic, assign, readonly) EnumOrderStrategy strategy;
@property (nonatomic, strong, readonly) NSDecimalNumber *strategyPrice1;
@property (nonatomic, strong, readonly) NSString *txid;
@property (nonatomic, assign, readonly) EnumEnterOrderReason reason;
@property (nonatomic, strong, readonly) NSString* behalf;

- (id)initWithAccount:(NSString *)strAccount
             symbolID:(NSString *)strSymbolID
                 side:(EnumOrderSide)side
                 otype:(EnumOrderType)otype
             strategy:(EnumOrderStrategy)strategy
                price:(NSDecimalNumber *)numPrice
       strategyPrice1:(NSDecimalNumber *)numStrategyPrice1
                  qty:(NSDecimalNumber *)numQty
                 txid:(NSString *)strTXID
               reason:(EnumEnterOrderReason)reason behalf:(NSString*)behalf;
@end
