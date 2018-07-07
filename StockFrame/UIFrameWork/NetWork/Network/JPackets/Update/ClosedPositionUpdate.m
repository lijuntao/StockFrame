//
//  ClosedPositionUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "ClosedPositionUpdate.h"

@implementation ClosedPositionUpdateCore

- (id)init
{
    self = [super init];
    if (self)
    {
        _ID = nil;
        _time = nil;
        _sym = nil;
        _pl = nil;
        _sell = nil;
        _buy = nil;
        _qty = nil;
        _acpl = nil;
    }
    
    return self;
}
@end


@implementation ClosedPositionUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _account = nil;
        _closedPos = nil;
    }
    
    return self;
}


- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _account = [dict objectForKey:@(2)];
    
    NSArray *arrCore = [dict objectForKey:@(3)];
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dictCore in arrCore)
    {
        ClosedPositionUpdateCore *core = [ClosedPositionUpdateCore new];
        [core setID:[dictCore objectForKey:@(1)]];
        [core setTime:[dictCore objectForKey:@(2)]];
        [core setSym:[dictCore objectForKey:@(3)]];
        [core setPl:[dictCore objectForKey:@(4)]];
        [core setSell:[dictCore objectForKey:@(5)]];
        [core setBuy:[dictCore objectForKey:@(6)]];
        [core setQty:[dictCore objectForKey:@(7)]];
        [core setAcpl:[dictCore objectForKey:@(8)]];
        [arr addObject:core];
    }
    _closedPos = arr;
}
@end
