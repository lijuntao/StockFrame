//
//  WmCalculateOrderUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface WmCalculateOrderUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *sym;
@property (nonatomic) EnumWMOrderType order_type;
/**
 *  下單價位
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *price;

/**
 *  買或賣多少單位
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *qty;
@property (nonatomic, strong, readonly) NSDecimalNumber *ccas;
@property (nonatomic, strong, readonly) NSDecimalNumber *commission;
@property (nonatomic, strong, readonly) NSDecimalNumber *stampduty;
@property (nonatomic, strong, readonly) NSDecimalNumber *levy;
@property (nonatomic, strong, readonly) NSDecimalNumber *total;
@property (nonatomic, strong, readonly) NSDecimalNumber *amount;

@end
