//
//  GlobalSetting.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/12/21.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "GlobalSetting.h"

@implementation GlobalSetting
@synthesize dict = _dict;

- (id)initWithMarket:(NSString *)market
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_GlobalSetting;
        self.seq = [JPacketSendBase getSeqIncreased];
        _market = market;

        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (market)
            [dict setObject:market forKey:@(3)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GlobalSetting (%d)\n\t", EnumPacketPT_GlobalSetting];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"market: %@\n\t", _market];
    
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
