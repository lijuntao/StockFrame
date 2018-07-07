//
//  SymbolListUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "SymbolListUpdate.h"

@implementation SymbolListUpdateCore

- (id)init
{
    self = [super init];
    if (self)
    {
        _sym = nil;
        _en_name = nil;
        _cn_name = nil;
        _tw_name = nil;
        _st_name = nil;
        _type_name = nil;
        _sub_name = nil;
        _ticktable = nil;
        _lotsz = nil;
        _decimal = nil;
        _ppu = nil;
        _tunit = nil;
        _maxlot = nil;
        _maxMlot = nil;
        _maxhold = nil;
        _cmsn = nil;
        _mrate = nil;
        _tradable = nil;
        _sesname = nil;
        _symtype = nil;
        _section = nil;
        _night_trade = false;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _sym = [dict objectForKey:@(1)];
    _en_name = [dict objectForKey:@(2)];
    _cn_name = [dict objectForKey:@(3)];
    _tw_name = [dict objectForKey:@(4)];
    _st_name = [dict objectForKey:@(5)];
    _type_name = [dict objectForKey:@(6)];
    _sub_name = [dict objectForKey:@(7)];
    _ticktable = [dict objectForKey:@(8)];
    _lotsz = [dict objectForKey:@(9)];
    _decimal = [dict objectForKey:@(10)];
    _ppu = [dict objectForKey:@(11)];
    _tunit = [dict objectForKey:@(12)];
    _maxlot = [dict objectForKey:@(13)];
    _maxhold = [dict objectForKey:@(14)];
    _cmsn = [dict objectForKey:@(15)];
    _mrate = [dict objectForKey:@(16)];
    _tradable = [dict objectForKey:@(17)];
    _maxMlot = [dict objectForKey:@(18)];
    _sesname = [dict objectForKey:@(19)];
    _symtype = [dict objectForKey:@(20)];
    _section = [dict objectForKey:@(21)];
    _night_trade = [dict objectForKey:@(22)];
    _shortsell = [dict objectForKey:@(23)];

    
}

@end

@implementation SymbolListUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _user = nil;
        _market = nil;
        _group = nil;
        _type = EnumSymbolListType_None;
        _txid = nil;
        _err = nil;
        _msg = nil;
        _d = nil;
        _qtype = EnumSymbolListQtype_EN;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _user = [dict objectForKey:@(2)];
    _market = [dict objectForKey:@(3)];
    _group = [dict objectForKey:@(4)];
    _type = [[dict objectForKey:@(5)] intValue];
    _txid = [dict objectForKey:@(6)];
    _err = [dict objectForKey:@(7)];
    _msg = [dict objectForKey:@(8)];
    
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dictCore in [dict objectForKey:@(9)])
    {
        SymbolListUpdateCore *core = [SymbolListUpdateCore new];
        [core fillData:dictCore];
        [arr addObject:core];
    }
    _d = arr;
    
    _qtype = [[dict objectForKey:@(10)] intValue];
}
@end
