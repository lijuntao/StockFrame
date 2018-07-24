//
//  ChartUpdatePacket.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "ChartUpdate.h"
#import "ChartKItem.h"


@implementation ChartUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _symbolID = nil;
        _ctype = JPacket_INVALID;
        _freq = nil;
        _period = nil;
        _sn = JPacket_INVALID;
        _total = JPacket_INVALID;
        _d = nil;
        _session = nil;
    }
    
    return self;
}
- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    if ([[dict allKeys] containsObject:@(2)])
        self.seq = [[dict objectForKey:@(2)] intValue];
    
    if ([[dict allKeys] containsObject:@(3)])
        _symbolID = [dict objectForKey:@(3)];
    
    if ([[dict allKeys] containsObject:@(4)])
        _ctype = [[dict objectForKey:@(4)] intValue];
    
    if ([[dict allKeys] containsObject:@(5)])
        _freq = [dict objectForKey:@(5)];
    
    if ([[dict allKeys] containsObject:@(6)])
        _sn = [[dict objectForKey:@(6)] intValue];
    
    if ([[dict allKeys] containsObject:@(7)])
        _total = [[dict objectForKey:@(7)] intValue];
    
    if ([[dict allKeys] containsObject:@(14)])
        _count = [[dict objectForKey:@(14)] intValue];
    
    if ([[dict allKeys] containsObject:@(9)])
        _period = [dict objectForKey:@(9)];
    
    if ([[dict allKeys] containsObject:@(10)])
        _session = [dict objectForKey:@(10)];
    
    if ([[dict allKeys] containsObject:@(11)])
        _base = [dict objectForKey:@(11)];
    
    NSArray *arrData = [dict objectForKey:@(8)];
    NSMutableArray *arrParsedData = [NSMutableArray new];
    
    
    NSNumber *numDate = nil; //当前日期

    for (NSDictionary *dictTickRawData in arrData)
    {
        id data = nil;
        if (_ctype == 1)
            data = [ChartLineItem new];
        if (_ctype == 2)
            data = [ChartKItem new];
        
        if ([[dictTickRawData allKeys] containsObject:@(11)]){
            NSNumber *tmp = [dictTickRawData objectForKey:@(11)];
            if ([tmp intValue] != 0) {
                numDate = tmp;
            }
        }
        if (numDate) {
            [data setTrddate:numDate];
            [data setTdate:numDate];
        }
        
        if ([[dictTickRawData allKeys] containsObject:@(2)])
            [data setHhmm:[dictTickRawData objectForKey:@(2)]];
        
        if ([[dictTickRawData allKeys] containsObject:@(3)])
            [data setClose:[dictTickRawData objectForKey:@(3)]];
        
        if ([[dictTickRawData allKeys] containsObject:@(7)])
            [data setVolume:[dictTickRawData objectForKey:@(7)]];
        
        if ([[dictTickRawData allKeys] containsObject:@(9)])
            [data setVolumeStr:[dictTickRawData objectForKey:@(9)]];
        
        if ([[dictTickRawData allKeys] containsObject:@(8)])
            [data setDataTime:[dictTickRawData objectForKey:@(8)]];
        
        if ([[dictTickRawData allKeys] containsObject:@(10)])
            [data setAvgPX:[dictTickRawData objectForKey:@(10)]];
        
        if (_ctype == 2) {
            if ([[dictTickRawData allKeys] containsObject:@(4)])
                [data setOpen:[dictTickRawData objectForKey:@(4)]];
            
            if ([[dictTickRawData allKeys] containsObject:@(5)])
                [data setHigh:[dictTickRawData objectForKey:@(5)]];
            
            if ([[dictTickRawData allKeys] containsObject:@(6)])
                [data setLow:[dictTickRawData objectForKey:@(6)]];
            
            if ([[dictTickRawData allKeys] containsObject:@(12)] && [[dictTickRawData objectForKey:@(12)] doubleValue] != 0) {
                [data setForward_close:[dictTickRawData objectForKey:@(12)]];
            }
            if ([[dictTickRawData allKeys] containsObject:@(13)] && [[dictTickRawData objectForKey:@(13)] doubleValue] != 0) {
                [data setForward_open:[dictTickRawData objectForKey:@(13)]];
            }
            if ([[dictTickRawData allKeys] containsObject:@(14)] && [[dictTickRawData objectForKey:@(14)] doubleValue] != 0) {
                [data setForward_high:[dictTickRawData objectForKey:@(14)]];
            }
            if ([[dictTickRawData allKeys] containsObject:@(15)] && [[dictTickRawData objectForKey:@(15)] doubleValue] != 0) {
                [data setForward_low:[dictTickRawData objectForKey:@(15)]];
            }
            
            if ([[dictTickRawData allKeys] containsObject:@(16)] && [[dictTickRawData objectForKey:@(16)] doubleValue] != 0) {
                [data setBackward_close:[dictTickRawData objectForKey:@(16)]];
            }
            if ([[dictTickRawData allKeys] containsObject:@(17)] && [[dictTickRawData objectForKey:@(17)] doubleValue] != 0) {
                [data setBackward_open:[dictTickRawData objectForKey:@(17)]];
            }
            if ([[dictTickRawData allKeys] containsObject:@(18)] && [[dictTickRawData objectForKey:@(18)] doubleValue] != 0) {
                [data setBackward_high:[dictTickRawData objectForKey:@(18)]];
            }
            if ([[dictTickRawData allKeys] containsObject:@(19)] && [[dictTickRawData objectForKey:@(19)] doubleValue] != 0) {
                [data setBackward_low:[dictTickRawData objectForKey:@(19)]];
            }
        }
        
        [arrParsedData addObject:data];
    }
    _d = arrParsedData;
}
@end
