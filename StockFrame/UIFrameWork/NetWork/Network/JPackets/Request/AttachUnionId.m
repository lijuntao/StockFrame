//
//  AttachUnionId.m
//  MasterDataManager
//
//  Created by jiangnan on 15/12/29.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "AttachUnionId.h"

@implementation AttachUnionId

@synthesize dict = _dict;

- (instancetype)initWithTxid:(NSString*)txid
                      OpenId:(NSString *)openId
                       unionId:(NSString *)unionId
                        market:(NSString *)market
                      language:(NSString *)lang
{
    if (self = [super init])
    {
        self.pt = EnumPacketPT_UserLogin;
        self.seq = [JPacketSendBase getSeqIncreased];
        self.txid = txid;
        self.openid = openId;
        self.unionid = unionId;
        self.market = market;
        self.language = lang;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:self.txid forKey:@(3)];
        [dict setObject:self.openid forKey:@(4)];
        [dict setObject:self.unionid forKey:@(5)];
        [dict setObject:self.market forKey:@(6)];
        [dict setObject:self.language forKey:@(7)];
        
        _dict = (NSDictionary *)dict;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: AttachUnionId(%d)\n\t", EnumPacketPT_AttachUnionId];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"openId: %@\n\t", self.openid];
    [strRet appendFormat:@"unionId: %@\n\t", self.unionid];
    [strRet appendFormat:@"market: %@\n\t", self.market];
    [strRet appendFormat:@"language: %@\n\t", self.language];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
