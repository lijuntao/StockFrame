//
//  TickLineItem.m
//  MasterDataManager
//
//  Created by Joseph on 2014/6/9.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "ChartLineItem.h"

@implementation ChartLineItem

- (id)copyWithZone:(NSZone *)zone
{
    ChartLineItem *item = [[[self class] allocWithZone:zone] init];
    if (item)
    {
        [item setYyyymmdd:[_yyyymmdd copy]];
        [item setHhmm:[_hhmm copy]];
        [item setClose:[_close copy]];
        [item setVolumeStr:[_volumeStr copy]];
        [item setDataTime:[_dataTime copy]];
        [item setAvgPX:[_avgPX copy]];
        [item setTrddate:[_trddate copy]];
    }
    
    return item;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:_yyyymmdd forKey:@"yyyymmdd"];
    [encoder encodeObject:_hhmm forKey:@"hhmm"];
    [encoder encodeObject:_close forKey:@"close"];
    [encoder encodeObject:_volumeStr forKey:@"volumeStr"];
    [encoder encodeObject:_dataTime forKey:@"dataTime"];
    [encoder encodeObject:_avgPX forKey:@"avgPX"];
    [encoder encodeObject:_trddate forKey:@"trddate"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _yyyymmdd  = [decoder decodeObjectForKey:@"yyyymmdd"];
        _hhmm      = [decoder decodeObjectForKey:@"hhmm"];
        _close     = [decoder decodeObjectForKey:@"close"];
        _volumeStr = [decoder decodeObjectForKey:@"volumeStr"];
        _dataTime  = [decoder decodeObjectForKey:@"dataTime"];
        _avgPX     = [decoder decodeObjectForKey:@"avgPX"];
        _trddate   = [decoder decodeObjectForKey:@"trddate"];
    }
    return self;
}


- (NSString *)chartDate{
    NSString *time = [NSString stringWithFormat:@"%04d",_hhmm.intValue];
    return [_yyyymmdd.stringValue stringByAppendingFormat:@" %@",time];
}

- (NSString *)chartTradeDate{
    NSString *time = [NSString stringWithFormat:@"%04d",_hhmm.intValue];
    return [_trddate.stringValue stringByAppendingFormat:@" %@",time];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone{
    ChartLineItem *kItme = [[ChartLineItem allocWithZone:zone]init];
    
    kItme.close = self.close;
    
    kItme.trddate = self.trddate;
    kItme.yyyymmdd = self.yyyymmdd;
    kItme.hhmm = self.hhmm;
    kItme.dataTime = self.dataTime;
    kItme.volumeStr = self.volumeStr;
    kItme.avgPX = self.avgPX;
    
    return kItme;
}

@end
