//
//  GetLastTradeDateQuote.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "GetLastTradeDateQuote.h"

@implementation GetLastTradeDateQuote
@synthesize dict = _dict;

- (id)initWithMarket:(NSString *)strMarket symbolID:(NSString *)symbolID sesname:(NSString *)strSesname
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_GetLastTradeDateQuote;
        self.seq = [JPacketSendBase getSeqIncreased];
        _market = strMarket;
        _sesname = strSesname;
        if (symbolID)
            _sym = symbolID;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:strMarket forKey:@(3)];
        if (_sym)
            [dict setObject:@[@{@(1):_sym}] forKey:@(4)];
        
        if (strSesname)
            [dict setObject:strSesname forKey:@(5)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetLastTradeDateQuote (%d)\n\t", EnumPacketPT_GetLastTradeDateQuote];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"market: %@\n\t", _market];
    if (_sym)
        [strRet appendFormat:@"sym: %@", _sym];
    [strRet appendFormat:@"sesname: %@\n\t", _sesname];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
