//
//  WmExchangeRateUpdate.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/8/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"
@interface WmCurrencyRate : NSObject
@property (nonatomic, strong) NSString *to_currency;
@property (nonatomic, strong) NSDecimalNumber *rate;
@end

@interface WmCurrencyRates : NSObject
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSArray<WmCurrencyRate *> *exchagneRates;

@end

@interface WmExchangeRateUpdate : JPacketReceiveBase
@property (nonatomic, strong) NSArray<WmCurrencyRates *> *currencyRateInfos;
@end
