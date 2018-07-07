//
//  WmGetJson.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/18.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmGetJson.h"

@implementation WmGetJson
@synthesize dict = _dict;

- (id)initWithType:(NSString *)param_json {
    
    self = [super init];
    if (self) {
        self.pt = EnumPacketPT_WmWmGetJson;
        self.seq = [JPacketSendBase getSeqIncreased];
        _dict = [NSMutableDictionary new];
        _param_json = param_json;
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:self.param_json forKey:@(3)];

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
    
    [strRet appendFormat:@"param_json: %@\n\t", self.param_json];

    
    [strRet appendString:@"\n}\n"];
    return strRet;
}
@end
