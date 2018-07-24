//
//  SubscribeChart.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "SubscribeChart.h"

@implementation SubscribeChart

@synthesize dict = _dict;

- (id)initWithRefSymbolIDs:(NSArray *)arrRefSymbolID
            unrefSymbolIDs:(NSArray *)arrUnrefSymbolID
                  clearAll:(BOOL)bClearAll
                     ctype:(EnumChartType)ctype
                      freq:(NSString *)strFreq
                    period:(NSString *)strPeriod
                     count:(NSInteger)nCount
                     trddate:(NSNumber *)trddate
                     tdate:(NSNumber *)tdate
                     time:(NSNumber *)time
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_SubscribeChart;
        self.seq = [JPacketSendBase getSeqIncreased];
        _refSymbolIDs = arrRefSymbolID;
        _unrefSymbolIDs = arrUnrefSymbolID;
        _clearAll = bClearAll;
        NSString *strSubribe = [self makeCurrentSubcribeString];
        _ctype = ctype;
        _freq = strFreq;
        _period = strPeriod;
        _count = nCount;
        _trddate = trddate;
        _tdate = tdate;
        _time = time;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strSubribe)
            [dict setObject:strSubribe forKey:@(3)];
        _strSubribe = strSubribe;
        
        [dict setObject:@(_ctype) forKey:@(4)];
        if (strFreq)
            [dict setObject:strFreq forKey:@(5)];
        
        if (nCount != JPacket_INVALID && ![strPeriod isEqualToString:@"DC"])
            [dict setObject:@(nCount) forKey:@(6)];
        
        if (strPeriod)
            [dict setObject:strPeriod forKey:@(7)];
        
        if (trddate && nCount != JPacket_INVALID)
            [dict setObject:trddate forKey:@(8)];
        
        if (tdate && nCount != JPacket_INVALID)
            [dict setObject:tdate forKey:@(9)];
        
        if (time && nCount != JPacket_INVALID)
            [dict setObject:time forKey:@(10)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}

- (NSString *)makeCurrentSubcribeString
{
    NSMutableString *str = [NSMutableString new];
    if (_clearAll)
        [str appendString:@"*;"];
    
    if (_refSymbolIDs)
    {
        for (NSString *strSymbolID in _refSymbolIDs)
        {
            [str appendString:strSymbolID];
            [str appendString:@";"];
        }
    }
    
    if (_unrefSymbolIDs)
    {
        for (NSString *strSymbolID in _unrefSymbolIDs)
        {
            [str appendString:@"-"];
            [str appendString:strSymbolID];
            [str appendString:@";"];
        }
    }
    
    if ([str length] > 0)
        return [str substringToIndex:[str length] - 1];
    else
        return nil;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: SubscribeChart (%d)\n\t", EnumPacketPT_SubscribeChart];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    if (_strSubribe)
        [strRet appendFormat:@"id: %@\n\t", _strSubribe];
    [strRet appendFormat:@"ctype: %d\n\t", _ctype];
    if (_freq)
        [strRet appendFormat:@"freq: %@\n\t", _freq];
    if (_period)
        [strRet appendFormat:@"period: %@\n\t", _period];
    if (_count != JPacket_INVALID)
        [strRet appendFormat:@"count: %ld\n\t", (long)_count];
    if (_trddate)
        [strRet appendFormat:@"ltrddate: %@\n\t", _trddate];
    if (_tdate)
        [strRet appendFormat:@"ltdate: %@\n\t", _tdate];
    if (_time)
        [strRet appendFormat:@"ltime: %@\n\t", _time];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
