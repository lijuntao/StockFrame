//
//  WmEnterOder.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"


@interface WmEnterOrder : JPacketSendBase


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

/**
 *  0: Limit Order
 3: Odd Lot Order
 512: Auction Order
 2048: Stop Limit Order
 */
@property (nonatomic, assign, readonly) EnumWMInstruct instruct;
/**
 *  Optional，若為 Stop Limit Order 單時，請指定Stop Loss Price
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *instruct_prc1;

- (id)initWithSymbolId:(NSString *)strSymbolId
                otype:(EnumWMOrderType)order_type
                price:(NSDecimalNumber *)numPrice
                  qty:(NSDecimalNumber *)numQty
                 txid:(NSString *)strTxid
               instruct:(EnumWMInstruct)instruct
                instruct_prc1:(NSDecimalNumber*)instruct_prc1;
@end
