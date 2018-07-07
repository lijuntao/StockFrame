//
//  SearchSymbolUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "SearchSymbolUpdate.h"

@implementation SearchSymbolUpdateCore

- (id)init
{
    self = [super init];
    if (self)
    {
        _sym = nil;
        _en_name = nil;
        _cn_name = nil;
        _tw_name = nil;
        _type_name = nil;
        _st_name = nil;
        _sub_name = nil;
        _type_desc = nil;
        _type_symbol = nil;
        _night_trade = false;
        _section = nil;
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
    _type_name = [dict objectForKey:@(5)];
    _st_name = [dict objectForKey:@(6)];
    _sub_name = [dict objectForKey:@(7)];
    _type_desc = [dict objectForKey:@(8)];
    _type_symbol = [dict objectForKey:@(9)];
    _night_trade = [dict objectForKey:@(10)];
    _section = [dict objectForKey:@(11)];
    
}

@end

@implementation SearchSymbolUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _market = nil;
        _txid = nil;
        _keyword = nil;
        _type = EnumSearchSymbolType_Code;
        _page = nil;
        _sympage = nil;
        _totalpage = nil;
        _err = nil;
        _msg = nil;
        _d = nil;
        _cat = EnumSearchSymbolCat_All;
        _symbolType = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _market = [dict objectForKey:@(2)];
    _txid = [dict objectForKey:@(3)];
    _keyword = [dict objectForKey:@(4)];
    _type = [[dict objectForKey:@(5)] intValue];
    _page = [dict objectForKey:@(6)];
    _sympage = [dict objectForKey:@(7)];
    _totalpage = [dict objectForKey:@(8)];
    _err = [dict objectForKey:@(9)];
    _msg = [dict objectForKey:@(10)];
    
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dictCore in [dict objectForKey:@(11)])
    {
        SearchSymbolUpdateCore *core = [SearchSymbolUpdateCore new];
        [core fillData:dictCore];
        [arr addObject:core];
    }
    _d = arr;
    
    if ([dict objectForKey:@(12)])
    {
        _cat = [[dict objectForKey:@(12)] intValue];
    }
}
@end
