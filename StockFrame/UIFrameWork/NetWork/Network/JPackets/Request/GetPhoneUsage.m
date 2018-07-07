//
//  GetPhoneUsage.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/7/21.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "GetPhoneUsage.h"

@implementation GetPhoneUsage

@synthesize dict = _dict;

-(instancetype)initWithTxid:(NSString *)txid
                      phone:(NSString *)phone
{
    self = [super init];
    if (self) {
        self.pt = EnumPacketPT_GetPhoneUsage;
        self.seq = [JPacketSendBase getSeqIncreased];
        _txid = txid;
        _phone = phone;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        [dict setObject:txid forKey:@(3)];
        [dict setObject:phone forKey:@(4)];

        _dict = (NSDictionary *)dict;
    }
    return self;
}
- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetPhoneUsage(%d)\n\t", EnumPacketPT_GetPhoneUsage];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendFormat:@"phone: %@\n\t", _phone];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
