//
//  TickTableUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "TickTableUpdate.h"

@implementation TickRangeValueSet

- (id)init
{
    self = [super init];
    if (self)
    {
        _delta = nil;
        _range = nil;
    }
    
    return self;
}
@end



@implementation TickTableUpdateRule

- (id)init
{
    self = [super init];
    if (self)
    {
        _key = nil;
        _valueSet = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    _key = [dict objectForKey:@(1)];
    
    NSMutableArray *arrValueSet = [NSMutableArray new];
    for (int i = 2; i <= 31; i += 2)
    {
        TickRangeValueSet *set = [TickRangeValueSet new];
        [set setRange:[dict objectForKey:@(i)]];
        [set setDelta:[dict objectForKey:@(i + 1)]];
        
        [arrValueSet addObject:set];
    }
    if ([arrValueSet count] > 0)
        _valueSet = arrValueSet;
}

@end



@implementation TickTableUpdate

- (id)init
{
    self = [super init];
    if (self)
    { 
        _err = nil;
        _msg = nil;
        _d = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    if ([[dict objectForKey:@(2)] isKindOfClass:[NSString class]])
        _err = [dict objectForKey:@(2)];
    
    if ([[dict objectForKey:@(3)] isKindOfClass:[NSString class]])
        _msg = [dict objectForKey:@(3)];
    
    if ([dict objectForKey:@(4)])
    {
        NSMutableArray *arrRule = [NSMutableArray new];
        NSArray *arr = [dict objectForKey:@(4)];
        for (NSDictionary *dictRule in arr)
        {
            TickTableUpdateRule *rule = [TickTableUpdateRule new];
            [rule fillData:dictRule];
            [arrRule addObject:rule];
        }
        if ([arrRule count] > 0)
            _d = arrRule;
    }
    
    
}
@end
