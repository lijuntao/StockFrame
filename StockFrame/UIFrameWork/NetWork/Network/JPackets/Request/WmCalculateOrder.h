//
//  WmCalculateOrder.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"


@interface WmCalculateOrder : JPacketSendBase

//@property (nonatomic, assign, readonly) NSInteger seq;

/**
 *  40 bytes以內的unique string, 不可為空值
 */
@property (nonatomic, strong, readonly) NSString *txid;
/**
 *  商品代碼
 */
@property (nonatomic, strong, readonly) NSString *sym;

/**
 *  0: 買進
 1: 賣出
 */
@property (nonatomic, assign, readonly) EnumWMOrderType order_type;

/**
 *  下單價位
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *price;

/**
 *  買或賣多少單位
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *qty;


- (id)initWithSymbolId:(NSString *)strSymbolId
                 otype:(EnumWMOrderType)order_type
                 price:(NSDecimalNumber *)numPrice
                   qty:(NSDecimalNumber *)numQty
                  txid:(NSString *)strTxid;

@end
