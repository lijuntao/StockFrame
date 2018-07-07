//
//  Connect.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/10/3.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "Connect.h"

@implementation Connect

@synthesize dict = _dict;

- (id)initWithAppID:(NSString *)strAppID cliendID:(NSString *)strCliendID ver:(NSString *)strVer
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_Connect;
        self.seq = [JPacketSendBase getSeqIncreased];
        _appid = strAppID;
        _clientid = strCliendID;
        _ver = strVer;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strAppID)
            [dict setObject:strAppID forKey:@(3)];
        
        if (strCliendID)
            [dict setObject:strCliendID forKey:@(4)];
        
        if (strVer)
            [dict setObject:strVer forKey:@(5)];
        
        _dict = (NSDictionary *)dict;
    }
    
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: Connect (%d)\n\t", EnumPacketPT_Connect];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"appid: %@\n\t", _appid];
    [strRet appendFormat:@"clientid: %@\n\t", _clientid];
    [strRet appendFormat:@"ver: %@", _ver];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
