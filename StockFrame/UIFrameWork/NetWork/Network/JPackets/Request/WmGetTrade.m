//
//  WmGetTrade.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/23.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmGetTrade.h"

@implementation WmGetTrade


@synthesize dict = _dict;

- (id)init{
    self = [super init];
    if (self) {
        self.pt = EnumPacketPT_WmGetTrade;
        self.seq = [JPacketSendBase getSeqIncreased];
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        _dict = (NSDictionary *)dict;
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: %@ (%d)\n\t",NSStringFromClass(self.class) ,self.pt];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendString:@"\n}\n"];
    return strRet;
}

@end
