//
//  WmAmendOrder.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface WmAmendOrder : JPacketSendBase

@property (nonatomic, strong, readonly) NSString *Id;
@property (nonatomic, strong, readonly) NSString *txid;
@property (nonatomic, strong, readonly) NSDecimalNumber *price;
@property (nonatomic, strong, readonly) NSDecimalNumber *qty;

- (id)initWithId:(NSString *)Id
            txid:(NSString *)txid
           price:(NSDecimalNumber *)price
             qty:(NSDecimalNumber *)qty;
@end
