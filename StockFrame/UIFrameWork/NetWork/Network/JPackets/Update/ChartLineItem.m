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
        [item setTrddate:[_trddate copy]];
        [item setTdate:[_tdate copy]];
        [item setHhmm:[_hhmm copy]];
        [item setDataTime:[_dataTime copy]];
        [item setClose:[_close copy]];
        [item setVolume:[_volume copy]];
        [item setVolumeStr:[_volumeStr copy]];
        [item setAvgPX:[_avgPX copy]];
    }
    
    return item;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone{
    
    ChartLineItem *kItme = [[ChartLineItem allocWithZone:zone]init];
    kItme.trddate = self.trddate;
    kItme.tdate = self.tdate;
    kItme.hhmm = self.hhmm;
    kItme.dataTime = self.dataTime;
    kItme.close = self.close;
    kItme.volume = self.volume;
    kItme.volumeStr = self.volumeStr;
    kItme.avgPX = self.avgPX;
    return kItme;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:_trddate forKey:@"trddate"];
    [encoder encodeObject:_tdate forKey:@"tdate"];
    [encoder encodeObject:_hhmm forKey:@"hhmm"];
    [encoder encodeObject:_dataTime forKey:@"dataTime"];
    [encoder encodeObject:_close forKey:@"close"];
    [encoder encodeObject:_volume forKey:@"volume"];
    [encoder encodeObject:_volumeStr forKey:@"volumeStr"];
    [encoder encodeObject:_avgPX forKey:@"avgPX"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _trddate   = [decoder decodeObjectForKey:@"trddate"];
        _tdate  = [decoder decodeObjectForKey:@"tdate"];
        _hhmm      = [decoder decodeObjectForKey:@"hhmm"];
        _dataTime  = [decoder decodeObjectForKey:@"dataTime"];
        _close     = [decoder decodeObjectForKey:@"close"];
        _volume   = [decoder decodeObjectForKey:@"volume"];
        _volumeStr = [decoder decodeObjectForKey:@"volumeStr"];
        _avgPX     = [decoder decodeObjectForKey:@"avgPX"];
    }
    return self;
}


//- (NSString *)chartDate{
//    NSString *time = [NSString stringWithFormat:@"%04d",_hhmm.intValue];
//    return [_hhmm.stringValue stringByAppendingFormat:@" %@",time];
//}
//
//- (NSString *)chartTradeDate{
//    NSString *time = [NSString stringWithFormat:@"%04d",_trddate.intValue];
//    return [_trddate.stringValue stringByAppendingFormat:@" %@",time];
//}

@end
