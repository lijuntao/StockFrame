//
//  ProfitUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"
@interface ProfitUpdateSymbol : NSObject

@property (nonatomic, strong) NSString *symbolID;
@property (nonatomic, strong) NSDecimalNumber *urpl;
@property (nonatomic, strong) NSDecimalNumber *cumQty;
@property (nonatomic, strong) NSString *avgPrice;
@property (nonatomic, strong) NSDecimalNumber *avalqty;

@end

@interface ProfitUpdateCore : NSObject

@property (nonatomic, strong) NSDecimalNumber *value;
@property (nonatomic, strong) NSDecimalNumber *cash;
@property (nonatomic, strong) NSDecimalNumber *margin;
@property (nonatomic, strong) NSDecimalNumber *dpl;
@property (nonatomic, strong) NSDecimalNumber *pl;
@property (nonatomic, strong) NSDecimalNumber *urpl;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSDecimalNumber *cavaliable;
@property (nonatomic, strong) NSDecimalNumber *cdeduct;
@property (nonatomic, strong) NSDecimalNumber *start_value;
@property (nonatomic, strong) NSDecimalNumber *cashdep;
@property (nonatomic, strong) NSDecimalNumber *allpl;
@property (nonatomic, strong) NSDecimalNumber *rprc;
@property (nonatomic, strong) NSDecimalNumber *uprc;


@end

@interface ProfitUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) ProfitUpdateCore *accountPL;
@property (nonatomic, strong) NSArray *pos;
@end
