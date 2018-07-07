//
//  ProfitUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "ProfitUpdate.h"

@implementation ProfitUpdateSymbol
- (id)init
{
    self = [super init];
    if (self)
    {
        _symbolID = nil;
        _urpl = nil;
        _cumQty = nil;
        _avgPrice = nil;
    }
    
    return self;
}
@end

@implementation ProfitUpdateCore
- (id)init
{
    self = [super init];
    if (self)
    {
        
        _value = nil;
        _cash = nil;
        _margin = nil;
        _dpl = nil;
        _pl = nil;
        _urpl = nil;
        _currency = nil;
        _cavaliable = nil;
        _cdeduct = nil;
        _start_value = nil;
        _cashdep = nil;
        _allpl = nil;
        _rprc = nil;
        _uprc = nil;
    }
    
    return self;
}
@end

@implementation ProfitUpdate
- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _account = [dict objectForKey:@(2)];
    
    if ([[dict allKeys] containsObject:@(3)])
    {
        NSDictionary *dictCore = [dict objectForKey:@(3)];
        
        ProfitUpdateCore *corePL = [ProfitUpdateCore new];
        [corePL setValue:[dictCore objectForKey:@(1)]];
        [corePL setCash:[dictCore objectForKey:@(2)]];
        [corePL setMargin:[dictCore objectForKey:@(3)]];
        [corePL setDpl:[dictCore objectForKey:@(4)]];
        [corePL setPl:[dictCore objectForKey:@(5)]];
        [corePL setUrpl:[dictCore objectForKey:@(6)]];
        [corePL setCurrency:[dictCore objectForKey:@(7)]];
        [corePL setCavaliable:[dictCore objectForKey:@(8)]];
        [corePL setCdeduct:[dictCore objectForKey:@(9)]];
        [corePL setStart_value:[dictCore objectForKey:@(10)]];
        [corePL setCashdep:[dictCore objectForKey:@(11)]];
        [corePL setAllpl:[dictCore objectForKey:@(12)]];
        [corePL setRprc:[dictCore objectForKey:@(13)]];
        [corePL setUprc:[dictCore objectForKey:@(14)]];
        
        _accountPL = corePL;
    }
    
    if ([[dict allKeys] containsObject:@(4)])
    {
        NSArray *d = [dict objectForKey:@(4)];
        NSMutableArray *arrParsedData = [NSMutableArray new];
        for (NSDictionary *dictSymbol in d)
        {
            ProfitUpdateSymbol *symbolPL = [ProfitUpdateSymbol new];
            
            [symbolPL setSymbolID:[dictSymbol objectForKey:@(1)]];
            [symbolPL setUrpl:[dictSymbol objectForKey:@(2)]];
            [symbolPL setCumQty:[dictSymbol objectForKey:@(3)]];
            [symbolPL setAvgPrice:[dictSymbol objectForKey:@(4)]];
            
            [symbolPL setAvalqty:[dictSymbol objectForKey:@(5)]]; 
            [arrParsedData addObject:symbolPL];
        }
        
        _pos = arrParsedData;
    }
}
@end
