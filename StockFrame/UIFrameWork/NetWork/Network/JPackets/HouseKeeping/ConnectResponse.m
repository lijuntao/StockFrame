//
//  ConnectResponse.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/10/3.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "ConnectResponse.h"

@implementation ConnectResponse
@synthesize dict = _dict;

- (id)initWithRandomBytes:(NSData *)dataRandomByte
                 snapshot:(NSNumber *)numSnapShot
                  country:(NSString *)strCountry
                     lang:(NSString *)strLanguage
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_ConnectResponse;
        self.seq = [JPacketSendBase getSeqIncreased];
        _randomByte = dataRandomByte;
        _snapshot = 0;
        if (numSnapShot)
            _snapshot = [numSnapShot intValue];
        _country = strCountry;
        _lang = strLanguage;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (dataRandomByte)
            [dict setObject:dataRandomByte forKey:@(3)];
        
        if (numSnapShot)
            [dict setObject:@([numSnapShot intValue]) forKey:@(4)];
        
        if (strCountry)
            [dict setObject:strCountry forKey:@(6)];
        
        if (strLanguage)
            [dict setObject:strLanguage forKey:@(7)];
        
        _dict = (NSDictionary *)dict;
    }
    
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: ConnectResponse (%d)\n\t", EnumPacketPT_ConnectResponse];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"r: %@\n\t", _randomByte];
    if (_snapshot > 0)
        [strRet appendFormat:@"snapshot: %ld\n\t", (long)_snapshot];
    if (_country)
        [strRet appendFormat:@"country: %@\n\t", _country];
    if (_lang)
        [strRet appendFormat:@"language: %@\n\t", _lang];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
