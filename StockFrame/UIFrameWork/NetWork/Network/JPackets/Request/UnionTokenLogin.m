//
//  UnionTokenLogin.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/1/27.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "UnionTokenLogin.h"

@implementation UnionTokenLogin

@synthesize dict = _dict;
- (id)initWithToken:(NSString *)token
{
    self = [super init];
    if (self) {
        self.pt = EnumPacketPT_UnionTokenLogin;
        self.seq = [JPacketSendBase getSeqIncreased];
        self.waitingPacket = EnumPacketPT_UserUpdate;
        
        _token = token;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        [dict setObject:_token forKey:@(3)];

        _dict = (NSDictionary *)dict;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: UnionTokenLogin(%d)\n\t", EnumPacketPT_UnionTokenLogin];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"token: %@\n\t", _token];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
