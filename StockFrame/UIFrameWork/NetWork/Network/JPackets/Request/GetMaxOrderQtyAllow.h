//
//  GetMaxOrderQtyAllow.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/12/15.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"
@interface GetMaxOrderQtyAllow : JPacketSendBase



@property (nonatomic, strong, readonly) NSString *market;
@property (nonatomic, strong, readonly) NSString *userid;
@property (nonatomic, strong, readonly) NSString *account;
@property (nonatomic, strong, readonly) NSString *symbolid;
@property (nonatomic, strong, readonly) NSDecimalNumber *price;
@property (nonatomic, assign, readonly) EnumOrderSide side;
@property (nonatomic, assign, readonly) EnumOrderType otype;

@property (nonatomic, copy) NSString* txid;


- (id)initWithMarket:(NSString *)market
             userid:(NSString *)userid
             account:(NSString *)account
             symbolid:(NSString *)symbolid
                 side:(EnumOrderSide)side
               price:(NSDecimalNumber *)price
               otype:(EnumOrderType)otype
                txid:(NSString *)strTXID;

@end
