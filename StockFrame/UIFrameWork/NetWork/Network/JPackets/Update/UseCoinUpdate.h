//
//  UseCoinUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/10/1.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface UseCoinUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *txid;
@property (nonatomic, assign) EnumCoinFeature feautre;
@property (nonatomic, strong) NSNumber *coins;
@property (nonatomic, strong) NSNumber *auto_expand;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *market;


@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;

@property (nonatomic, strong) NSNumber *used_coins;
@property (nonatomic, strong) NSString *date_start;
@property (nonatomic, strong) NSString *date_end;
@property (nonatomic, strong) NSDecimalNumber *add_cash;

@end
