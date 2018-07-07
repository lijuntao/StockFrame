//
//  WmUnionTokenLogin.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmUnionTokenLogin.h"

@implementation WmUnionTokenLogin
@synthesize dict = _dict;
- (id)initWithToken:(NSString *)token
{
    self = [super init];
    if (self) {
        self.pt = EnumPacketPT_WmUnionTokenLogin;
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
    [strRet appendFormat:@"pt: WmUnionTokenLogin(%d)\n\t", EnumPacketPT_WmUnionTokenLogin];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"token: %@\n\t", _token];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
