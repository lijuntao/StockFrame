//
//  EncryptPacket.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/10/3.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "EncryptPacket.h"
#import "JPacketSendBase.h"

@implementation EncryptPacket

// For Send
- (id)initWithType:(EnumEncryptType)type dataEncrypted:(NSData *)dataEncrypted originalPacket:(JPacketSendBase *)oriPacket
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_Encrypt;
        self.seq = [JPacketSendBase getSeqIncreased];
        
        _type = type;
        _encryptedData = dataEncrypted;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(type) forKey:@(2)];
        
        if (dataEncrypted)
            [dict setObject:dataEncrypted forKey:@(3)];
        
        _dict = (NSDictionary *)dict;
        _oriPacket = oriPacket;
    }
    return self;
}

- (void)startSendoutTimer
{
    [_oriPacket startSendoutTimer];
}
- (void)stopSendoutTimer
{
    [_oriPacket stopSendoutTimer];
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"type: %d\n\t", _type];
    [strRet appendFormat:@"p: %@\n\t", _encryptedData];
    [strRet appendFormat:@"oriPT: %@", _oriPacket];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

// For Receive
- (void)fillData:(NSDictionary *)dict
{
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    if ([[dict allKeys] containsObject:@(1)])
        self.pt = [[dict objectForKey:@(1)] intValue];
    
    if ([[dict allKeys] containsObject:@(2)])
        _type = [[dict objectForKey:@(2)] intValue];
    
    if ([[dict allKeys] containsObject:@(3)])
        _encryptedData = [dict objectForKey:@(3)];
    
}
@end
