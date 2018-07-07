//
//  WmExchangeOrderUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/8/8.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface WmExchangeOrderUpdateCore : NSObject

@property (nonatomic, strong) NSString *sym;
@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, strong) NSDecimalNumber *qty;
@property (nonatomic, assign) EnumWMOrderStatus ostatus;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, assign) EnumWMOrderType order_type;
@property (nonatomic, strong) NSString *exchange;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSDecimalNumber *fillqty;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSDecimalNumber *avgprice;
@property (nonatomic, strong) NSDecimalNumber *credit;
@property (nonatomic, strong) NSDecimalNumber *queue_qty;
@property (nonatomic, strong) NSDecimalNumber *working_qty;
@property (nonatomic, assign) int minor_code;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *resource;
@property (nonatomic, assign) EnumWMInstruct instruct;

@end
@interface WmExchangeOrderUpdate : JPacketReceiveBase
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSArray *d;
@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *account;
@end
