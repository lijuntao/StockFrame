//
//  WmGetTradeHistory.m
//  MasterDataManager
//
//  Created by 姚晨峰 on 2017/5/2.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "WmGetTradeHistory.h"

@implementation WmGetTradeHistory
@synthesize dict = _dict;
-(id)initWithStart:(NSString *)start end:(NSString *)end{
    WmGetTradeHistory *i = [WmGetTradeHistory new];
    i.start_date = start;
    i.end_date = end;
    self = [super init];
    if (self) {
        self.pt = EnumPacketPT_WmWmGetTradeHistory;
        self.seq = [JPacketSendBase getSeqIncreased];
        NSMutableDictionary *dict = [NSMutableDictionary new];
        self.start_date = start;
        self.end_date = end;
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:self.start_date?:@"" forKey:@(3)];
        [dict setObject:self.end_date?:@"" forKey:@(4)];
        
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
    
    [strRet appendFormat:@"txid: %@\n\t", self.start_date];
    [strRet appendFormat:@"user: %@\n\t", self.end_date];
    
    
    [strRet appendString:@"\n}\n"];
    return strRet;
}
@end
