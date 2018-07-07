//
//  WmTradeUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/23.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface WmTradeUpdateCore : NSObject

@property (nonatomic, strong) NSString *sym;
@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, strong) NSDecimalNumber *qty;
@property (nonatomic, assign) EnumWMOrderStatus ostatus;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, assign) EnumWMOrderType order_type;
@property (nonatomic, strong) NSString *exchange;
@property (nonatomic, strong) NSString *time;

@end

@interface WmTradeUpdate : JPacketReceiveBase
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSArray *d;
@end
