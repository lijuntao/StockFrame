//
//  FavoriteSymbolUpdate.m
//  MasterDataManager
//
//  Created by ljt on 2017/11/7.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "FavoriteSymbolUpdate.h"

@implementation FavoriteSymbolUpdateCore

- (id)init
{
    self = [super init];
    if (self)
    {
        _symbol = nil;
        _tags = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _symbol = [dict objectForKey:@(1)];
    NSMutableArray *tagsArr = [NSMutableArray new];
    for (NSDictionary *dictCore in [dict objectForKey:@(2)])
    {
        NSString *core = [dictCore objectForKey:@(1)];
        [tagsArr addObject:core];
    }
    _tags = tagsArr;
}

@end

@implementation FavoriteSymbolUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _market = nil;
        _symbols = nil;
        _tags = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _market = [dict objectForKey:@(2)];
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dictCore in [dict objectForKey:@(3)])
    {
        FavoriteSymbolUpdateCore *core = [FavoriteSymbolUpdateCore new];
        [core fillData:dictCore];
        [arr addObject:core];
    }
    _symbols = arr;
    
    NSMutableArray *tagsArr = [NSMutableArray new];
    for (NSDictionary *dictCore in [dict objectForKey:@(4)])
    {
        NSString *core = [dictCore objectForKey:@(1)];
        [tagsArr addObject:core];
    }
    _tags = tagsArr;
}

@end
