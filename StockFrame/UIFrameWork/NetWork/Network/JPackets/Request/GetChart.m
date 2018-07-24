//
//  GetChart.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "GetChart.h"

@implementation GetChart
{
    NSString *_strSubribe;
}
@synthesize dict = _dict;
- (id)initWithSymbolIDs:(NSArray *)arrSymbolID
                  ctype:(EnumChartType)ctype
                   freq:(NSString *)strFreq
                 period:(NSString *)strPeriod
                  count:(int)nCount
                trddate:(NSNumber *)trddate
                  tdate:(NSNumber *)tdate
                   time:(NSNumber *)time
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_GetChart2;
        self.seq = [JPacketSendBase getSeqIncreased];
        _symbolIDs = arrSymbolID;
        NSString *strSubribe = [self makeCurrentSubcribeString];
        _ctype = ctype;
        _freq = strFreq;
        _period = strPeriod;
        _count = nCount;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strSubribe)
            [dict setObject:strSubribe forKey:@(3)];
        _strSubribe = strSubribe;
        
        [dict setObject:@(_ctype) forKey:@(4)];
        if (strFreq)
            [dict setObject:strFreq forKey:@(5)];
        
        [dict setObject:@(_count) forKey:@(6)];
        
        if (strPeriod)
            [dict setObject:strPeriod forKey:@(7)];
        
        _trddate = trddate;
        _tdate = tdate;
        _time = time;
        
        if (trddate && nCount != JPacket_INVALID)
            [dict setObject:trddate forKey:@(8)];
        
        if (tdate && nCount != JPacket_INVALID)
            [dict setObject:tdate forKey:@(9)];
        
        if (time && nCount != JPacket_INVALID)
            [dict setObject:time forKey:@(10)];
        
        [dict setObject:@1 forKey:@(11)];
        _dict = (NSDictionary *)dict;
    }
    return self;
}

- (id)initWithSymbolIDs:(NSArray *)arrSymbolID
                  ctype:(EnumChartType)ctype
                   freq:(NSString *)strFreq
                 period:(NSString *)strPeriod
                  count:(int)count
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_GetChart2;
        self.seq = [JPacketSendBase getSeqIncreased];
        _symbolIDs = arrSymbolID;
        NSString *strSubribe = [self makeCurrentSubcribeString];
        _ctype = ctype;
        _freq = strFreq;
        _period = strPeriod;
        _count = count;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strSubribe)
            [dict setObject:strSubribe forKey:@(3)];
        _strSubribe = strSubribe;
        
        [dict setObject:@(_ctype) forKey:@(4)];
        if (strFreq)
            [dict setObject:strFreq forKey:@(5)];
        
        [dict setObject:@(_count) forKey:@(6)];
        
        if (strPeriod)
            [dict setObject:strPeriod forKey:@(7)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)makeCurrentSubcribeString
{
    NSMutableString *str = [NSMutableString new];
    
    if (_symbolIDs)
    {
        for (NSString *strSymbolID in _symbolIDs)
        {
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
    [strRet appendFormat:@"pt: GetChart2 (%d)\n\t", EnumPacketPT_GetChart2];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    if (_strSubribe)
        [strRet appendFormat:@"id: %@\n\t", _strSubribe];
    [strRet appendFormat:@"ctype: %d\n\t", _ctype];
    if (_freq)
        [strRet appendFormat:@"freq: %@\n\t", _freq];
    if (_period)
        [strRet appendFormat:@"period: %@\n\t", _period];
    [strRet appendFormat:@"count: %ld\n\t", (long)_count];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
