//
//  WmExchangeRateUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/8/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmExchangeRateUpdate.h"
@implementation WmCurrencyRate
@end
@implementation WmCurrencyRates
@end
@implementation WmExchangeRateUpdate
- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    _currencyRateInfos = [dict objectForKey:@(2)];
    NSMutableArray *arr1 = [NSMutableArray new];
    for (NSDictionary *info in _currencyRateInfos) {
        NSString *from_currency = info[@(1)];
        NSArray *exchangeRates = info[@(2)];
        WmCurrencyRates *currencyRates = [WmCurrencyRates new];
        currencyRates.currency = from_currency;
        [arr1 addObject:currencyRates];
        NSMutableArray *arr2 = [NSMutableArray new];
        for (NSDictionary *singleRate in exchangeRates) {
            NSString *to_currency = singleRate[@(1)];
            NSDecimalNumber *rate = singleRate[@(2)];
            WmCurrencyRate *currencyRate = [WmCurrencyRate new];
            currencyRate.to_currency = to_currency;
            currencyRate.rate = rate;
            [arr2 addObject:currencyRate];
        }
        currencyRates.exchagneRates = arr2;
    }
    _currencyRateInfos = arr1;
    
}
@end
