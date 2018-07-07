//
//  GetUserPhone.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/21.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "GetUserPhone.h"

@implementation GetUserPhone
@synthesize dict = _dict;

- (id)initWithTxid:(NSString *)txid
              user:(NSString *)user{
    self = [super init];
    if (self) {
        self.pt = EnumPacketPT_GetUserPhone;
        self.seq = [JPacketSendBase getSeqIncreased];
        _dict = [NSMutableDictionary new];
        _txid = txid;
        _user = user;
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:self.txid forKey:@(3)];
        [dict setObject:self.user forKey:@(4)];
        
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
    
    [strRet appendFormat:@"txid: %@\n\t", self.txid];
    [strRet appendFormat:@"user: %@\n\t", self.user];
    
    
    [strRet appendString:@"\n}\n"];
    return strRet;
}
@end
