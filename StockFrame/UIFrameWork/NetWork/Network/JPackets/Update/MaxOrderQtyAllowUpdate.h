//
//  GetMaxOrderQtyAllowUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/12/15.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface MaxOrderQtyAllowUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSDecimalNumber *cavailable;
@property (nonatomic, strong) NSDecimalNumber *qty;
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;

@end
