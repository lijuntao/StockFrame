

//  WmGetOrderHistory.m
//  MasterDataManager
//
//  Created by 姚晨峰 on 2017/4/27.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "WmGetOrderHistory.h"

@implementation WmGetOrderHistory
@synthesize dict = _dict;
-(id)initWithStart:(NSString *)start end:(NSString *)end{
    WmGetOrderHistory *i = [WmGetOrderHistory new];
    i.start_date = start;
    i.end_date = end;
    self = [super init];
    if (self) {
        self.pt = EnumPacketPT_WmWmGetOrderHistory;
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
