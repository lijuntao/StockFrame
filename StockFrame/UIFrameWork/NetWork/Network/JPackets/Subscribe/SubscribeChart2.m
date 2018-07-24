//
//  SubscribeChart2.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/5/16.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "SubscribeChart2.h"

@implementation SubscribeChart2
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
        self.pt = EnumPacketPT_SubscribeChart2;
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
        
        if (nCount != JPacket_INVALID)
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
    [strRet appendFormat:@"pt: SubscribeChart2 (%ld)\n\t", (long)EnumPacketPT_SubscribeChart2];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    if (self.strSubribe)
        [strRet appendFormat:@"id: %@\n\t", self.strSubribe];
    [strRet appendFormat:@"ctype: %lu\n\t", (unsigned long)self.ctype];
    if (self.freq)
        [strRet appendFormat:@"freq: %@\n\t", self.freq];
    if (self.period)
        [strRet appendFormat:@"period: %@\n\t", self.period];
    if (self.count != JPacket_INVALID)
        [strRet appendFormat:@"count: %ld\n\t", (long)self.count];
    if (self.trddate)
        [strRet appendFormat:@"ltrddate: %@\n\t", self.trddate];
    if (self.tdate)
        [strRet appendFormat:@"ltdate: %@\n\t", self.tdate];
    if (self.time)
        [strRet appendFormat:@"ltime: %@\n\t", self.time];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
