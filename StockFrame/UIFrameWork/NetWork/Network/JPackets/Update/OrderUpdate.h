//
//  OrderUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface OrderUpdateCore : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, assign) EnumOrderActionType type;
@property (nonatomic, assign) EnumOrderStatus ostatus;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, assign) EnumOrderSide side;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSDecimalNumber *qty;
@property (nonatomic, strong) NSDecimalNumber *cumqty;
@property (nonatomic, strong) NSString *avgprice;
@property (nonatomic, strong) NSString *sym;
@property (nonatomic, assign) EnumOrderType otype;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) EnumOrderStrategy strategy;
@property (nonatomic, strong) NSString *strategy_prc1;
@property (nonatomic, assign) EnumOrderReason reason;

@end

@interface OrderUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSArray *d;
@property (nonatomic, strong) NSString *txid;


@end
