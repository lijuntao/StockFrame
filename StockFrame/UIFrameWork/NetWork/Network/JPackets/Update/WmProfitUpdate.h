//
//  WmProfitUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface PL : NSObject

@property (nonatomic, strong) NSString *sym;
@property (nonatomic, strong) NSDecimalNumber *qty;
@property (nonatomic, strong) NSDecimalNumber *avalqty;
@property (nonatomic, strong) NSString *price;

@end

@interface ExchangeRate : NSObject

@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSDecimalNumber *rate;
@property (nonatomic, strong) NSString *from_currency;


@end

@interface AccountPL : NSObject

@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSDecimalNumber *value;
@property (nonatomic, strong) NSDecimalNumber *balance;
@property (nonatomic, strong) NSDecimalNumber *bod_value;
@property (nonatomic, strong) NSDecimalNumber *bod_balance;
@property (nonatomic, strong) NSDecimalNumber *rlpl;
@property (nonatomic, strong) NSDecimalNumber *bodrlpl;

@end

@interface WmProfitUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSArray<AccountPL *> *accpls;
@property (nonatomic, strong) NSArray<ExchangeRate *> *exgrates;
@property (nonatomic, strong) NSArray<PL *> *pos;

@end
