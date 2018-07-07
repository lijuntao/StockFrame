//
//  GetExrightInfo.m
//  MasterDataManager
//
//  Created by fdt on 2017/12/26.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "GetExrightInfo.h"

@implementation GetExrightInfo

@synthesize dict = _dict;

-(instancetype)initWithSymbol:(NSString *)symbol {
    
    self = [super init];
    if (self) {
        self.pt = EnumPacketPT_GetExrightInfo;
        self.seq = [JPacketSendBase getSeqIncreased];
        _symbol = symbol;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (symbol){
            [dict setObject:symbol forKey:@(3)];
        }
        _dict = (NSDictionary *)dict;
    }
    return self;
}

- (NSString *)description {
    
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetExrightInfo(%d)\n\t", EnumPacketPT_GetExrightInfo];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"symbol: %@\n\t", _symbol];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
