//
//  WmProfitUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmProfitUpdate.h"

@implementation PL

@end

@implementation ExchangeRate

@end

@implementation AccountPL

@end

@implementation WmProfitUpdate
- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _user = [dict objectForKey:@(2)];
    
    if ([[dict allKeys] containsObject:@(3)])
    {
        NSArray *accpls = [dict objectForKey:@(3)];
        NSMutableArray *arrParsedData = [NSMutableArray new];
        for (NSDictionary *accplDict in accpls)
        {
            //港币账户忽略
            if ([[accplDict objectForKey:@(1)] isEqualToString:@"TWD"]) {
                continue;
            }
            
            AccountPL *accpl = [AccountPL new];
            
            [accpl setCurrency:[accplDict objectForKey:@(1)]];
            [accpl setValue:[accplDict objectForKey:@(2)]];
            [accpl setBalance:[accplDict objectForKey:@(3)]];
            [accpl setBod_value:[accplDict objectForKey:@(4)]];
            [accpl setBod_balance:[accplDict objectForKey:@(5)]];
            [accpl setRlpl:[accplDict objectForKey:@(6)]];
            [accpl setBodrlpl:[accplDict objectForKey:@(7)]];
             
            [arrParsedData addObject:accpl];
        }
        _accpls = arrParsedData;
    }
    
    
    if ([[dict allKeys] containsObject:@(4)])
    {
        NSArray *exgpls = [dict objectForKey:@(4)];
        NSMutableArray *arrParsedData = [NSMutableArray new];
        for (NSDictionary *exgplDict in exgpls)
        {
            ExchangeRate *exgpl = [ExchangeRate new];

            [exgpl setCurrency:[exgplDict objectForKey:@(1)]];
            [exgpl setRate:[exgplDict objectForKey:@(2)]];
            [exgpl setFrom_currency:[exgplDict objectForKey:@(3)]];
            
            [arrParsedData addObject:exgpl];
        }
        _exgrates = arrParsedData;
    }
    
    if ([[dict allKeys] containsObject:@(5)])
    {
        NSArray *pls = [dict objectForKey:@(5)];
        NSMutableArray *arrParsedData = [NSMutableArray new];
        for (NSDictionary *plDict in pls)
        {
            PL *pl = [PL new];
            
            [pl setSym:[plDict objectForKey:@(1)]];
            [pl setQty:[plDict objectForKey:@(2)]];
            [pl setPrice:[plDict objectForKey:@(3)]];
            [pl setAvalqty:[plDict objectForKey:@(4)]];
            
            [arrParsedData addObject:pl];
        }
        _pos = arrParsedData;
    }
    
    _account = [dict objectForKey:@(6)];
}
@end
