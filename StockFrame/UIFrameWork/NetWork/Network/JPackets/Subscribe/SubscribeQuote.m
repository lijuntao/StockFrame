//
//  SubscribeQuote.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "SubscribeQuote.h"

@implementation SubscribeQuote
{
    NSString *_strSubribe;
}
@synthesize dict = _dict;

- (id)initWithRefSymbolIDs:(NSArray *)arrRefSymbolID
            unrefSymbolIDs:(NSArray *)arrUnrefSymbolID
                  clearAll:(BOOL)bClearAll
                        fs:(NSInteger)nFS
                        ch:(NSInteger)nCH
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_SubscribeQuote;
        self.seq = [JPacketSendBase getSeqIncreased];
        _refSymbolIDs = arrRefSymbolID;
        _unrefSymbolIDs = arrUnrefSymbolID;
        _clearAll = bClearAll;
        _strSubribe = [self makeCurrentSubcribeString];
        _FS = nFS;
        _ch = nCH;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (_strSubribe)
            [dict setObject:_strSubribe forKey:@(3)];
        if (_FS != JPacket_INVALID)
            [dict setObject:@(_FS) forKey:@(4)];
        if (_ch != JPacket_INVALID)
            [dict setObject:@(_ch) forKey:@(5)];
        
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
//    static int debugSea = 0;
    
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: SubScribeQuote (%ld)\n\t", (long)EnumPacketPT_SubscribeQuote];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    if (_strSubribe)
        [strRet appendFormat:@"id: %@\n\t", _strSubribe];
    if (_FS != JPacket_INVALID)
        [strRet appendFormat:@"fs: %ld\n\t", (long)_FS];
    if (_ch != JPacket_INVALID)
        [strRet appendFormat:@"ch: %ld", (long)_ch];
    
    [strRet appendString:@"\n}\n"];
    return strRet;
}
@end
