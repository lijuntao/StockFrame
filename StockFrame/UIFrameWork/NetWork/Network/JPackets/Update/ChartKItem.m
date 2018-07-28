//
//  TickKItem.m
//  MasterDataManager
//
//  Created by Joseph on 2014/6/9.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "ChartKItem.h"

@implementation ChartKItem

- (id)copyWithZone:(NSZone *)zone
{
    ChartKItem *item = [super copyWithZone:zone];
//    TickKItem *item = [[[self class] allocWithZone:zone] init];
    if (item)
    {
        [item setOpen:[_open copy]];
        [item setHigh:[_high copy]];
        [item setLow:[_low copy]];
        
        [item setForward_close:[_forward_close copy]];
        [item setForward_open:[_forward_open copy]];
        [item setForward_high:[_forward_high copy]];
        [item setForward_low:[_forward_low copy]];
        
        [item setBackward_close:[_backward_close copy]];
        [item setBackward_open:[_backward_open copy]];
        [item setBackward_high:[_backward_high copy]];
        [item setBackward_low:[_backward_low copy]];
        [item setRightInfoDescs:[_rightInfoDescs copy]];
    }
    
    return item;
}
-(void)encodeWithCoder:(NSCoder *)encoder{
    
    [super encodeWithCoder:encoder];
    [encoder encodeObject:self.open forKey:@"open"];
    [encoder encodeObject:self.high forKey:@"high"];
    [encoder encodeObject:self.low forKey:@"low"];
    
    [encoder encodeObject:_forward_close forKey:@"forward_close"];
    [encoder encodeObject:_forward_open forKey:@"forward_open"];
    [encoder encodeObject:_forward_high forKey:@"forward_high"];
    [encoder encodeObject:_forward_low forKey:@"forward_low"];
    
    [encoder encodeObject:_backward_close forKey:@"backward_close"];
    [encoder encodeObject:_backward_open forKey:@"backward_open"];
    [encoder encodeObject:_backward_high forKey:@"backward_high"];
    [encoder encodeObject:_backward_low forKey:@"backward_low"];
    [encoder encodeObject:_rightInfoDescs forKey:@"rightInfoDescs"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        self.open = [decoder decodeObjectForKey:@"open"];
        self.high = [decoder decodeObjectForKey:@"high"];
        self.low = [decoder decodeObjectForKey:@"low"];
        
        self.forward_close = [decoder decodeObjectForKey:@"forward_close"];
        self.forward_open = [decoder decodeObjectForKey:@"forward_open"];
        self.forward_high = [decoder decodeObjectForKey:@"forward_high"];
        self.forward_low = [decoder decodeObjectForKey:@"forward_low"];
        
        self.backward_close = [decoder decodeObjectForKey:@"backward_close"];
        self.backward_open = [decoder decodeObjectForKey:@"backward_open"];
        self.backward_high = [decoder decodeObjectForKey:@"backward_high"];
        self.backward_low = [decoder decodeObjectForKey:@"backward_low"];
        self.rightInfoDescs = [decoder decodeObjectForKey:@"rightInfoDescs"];
    }
    return self;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone{
    ChartKItem *kItme = [ [ChartKItem allocWithZone:zone] init];
    kItme.open = self.open;
    kItme.close = self.close;
    kItme.high = self.high;
    kItme.low = self.low;
    
    kItme.forward_close = self.forward_close;
    kItme.forward_open = self.forward_open;
    kItme.forward_high = self.forward_high;
    kItme.forward_low = self.forward_low;
    
    kItme.backward_close = self.backward_close;
    kItme.backward_open = self.backward_open;
    kItme.backward_high = self.backward_high;
    kItme.backward_low = self.backward_low;
    
    kItme.trddate = self.trddate;
    kItme.tdate = self.tdate;
    kItme.hhmm = self.hhmm;
    kItme.dataTime = self.dataTime;
    kItme.volumeStr = self.volumeStr;
    kItme.avgPX = self.avgPX;
    kItme.rightInfoDescs = self.rightInfoDescs;
    
    return kItme;
}

-(NSNumber *)close{
    if (self.mode == KLINE_MODE_FORWARD_RIGHT && self.forward_close != nil){
        return self.forward_close;
    }
    
    if (self.mode == KLINE_MODE_BACKWARD_RIGHT && self.backward_close != nil) {
        return self.backward_close;
    }
    
    return [super close];
}

-(NSNumber *)open {
    if (self.mode == KLINE_MODE_FORWARD_RIGHT && self.forward_open != nil) {
        return self.forward_open;
    }
    
    if (self.mode == KLINE_MODE_BACKWARD_RIGHT && self.backward_open != nil) {
        return self.backward_open;
    }
    return _open;
}

-(NSNumber *)high {
    if (self.mode == KLINE_MODE_FORWARD_RIGHT && self.forward_high != nil) {
        return self.forward_high;
    }
    
    if (self.mode == KLINE_MODE_BACKWARD_RIGHT && self.backward_high != nil) {
        return self.backward_high;
    }
    return _high;
}

-(NSNumber *)low {
    if (self.mode == KLINE_MODE_FORWARD_RIGHT && self.forward_low != nil) {
        return self.forward_low;
    }
    
    if (self.mode == KLINE_MODE_BACKWARD_RIGHT && self.backward_low != nil) {
        return self.backward_low;
    }
    return _low;
}

-(void)applyFactor:(NSDecimalNumber *) factor lastFactor:(NSDecimalNumber *) lastFactor{
    if ([factor isEqualToValue:[NSDecimalNumber zero]] || [lastFactor isEqualToValue:[NSDecimalNumber zero]]) {
        return;
    }
    if (_backward_close == nil){
        _backward_close = @([[super close] doubleValue] * [factor doubleValue]);
        _forward_close = @([_backward_close doubleValue] / [lastFactor doubleValue]);
        
        _backward_open = @([_open doubleValue] * [factor doubleValue]);
        _forward_open = @([_backward_open doubleValue] / [lastFactor doubleValue]);
        
        _backward_high = @([_high doubleValue] * [factor doubleValue]);
        _forward_high = @([_backward_high doubleValue] / [lastFactor doubleValue]);
        
        _backward_low = @([_low doubleValue] * [factor doubleValue]);
        _forward_low = @([_backward_low doubleValue] / [lastFactor doubleValue]);
    }
}

@end
