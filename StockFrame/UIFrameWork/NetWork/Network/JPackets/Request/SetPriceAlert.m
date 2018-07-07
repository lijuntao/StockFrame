//
//  SetPriceAlert.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "SetPriceAlert.h"

@implementation SetPriceAlert
@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)strUser
            symbolID:(NSString *)strSymbolID
                type:(EnumSetPriceAlertType)type
               price:(NSDecimalNumber *)numPrice
                txid:(NSString *)strTXID
               msgid:(NSString *)strMsgID
               upper:(NSDecimalNumber *)numUpper
             downper:(NSDecimalNumber *)numDownper
             version:(NSInteger)version
              behalf:(NSString *)strBehalf
               token:(NSString *)token;
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_SetPriceAlert;
        self.seq = [JPacketSendBase getSeqIncreased];
        _user = strUser;
        _sym = strSymbolID;
        _type = type;
        _price = numPrice;
        _txid = strTXID;
        _msgid = strMsgID;
        _upper = numUpper;
        _downper = numDownper;
        _version = version;
        _behalf = strBehalf;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        if (strUser)
            [dict setObject:strUser forKey:@(3)];
        
        [dict setObject:strSymbolID forKey:@(4)];
        [dict setObject:@(type) forKey:@(5)];
        [dict setObject:numPrice forKey:@(6)];
        
        if (strTXID)
            [dict setObject:strTXID forKey:@(7)];
        
        if (strMsgID)
            [dict setObject:strMsgID forKey:@(8)];
        
        if (numUpper)
            [dict setObject:numUpper forKey:@(9)];
        
        if (numDownper)
            [dict setObject:numDownper forKey:@(10)];
        
        [dict setObject:@(version) forKey:@(11)];
        
        if (strBehalf)
            [dict setObject:strBehalf forKey:@(12)];
        if(token)
             [dict setObject:token forKey:@(13)];
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: SetPriceAlert(%d)\n\t", EnumPacketPT_SetPriceAlert];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"user: %@\n\t", _user];
    [strRet appendFormat:@"sym: %@\n\t", _sym];
    [strRet appendFormat:@"type: %d\n\t", _type];
    [strRet appendFormat:@"price: %@\n\t", _price];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    if (_msgid)
        [strRet appendFormat:@"msgid: %@\n\t", _msgid];
    
    [strRet appendFormat:@"upper: %@\n\t", _upper];
    [strRet appendFormat:@"downper: %@\n\t", _downper];
    [strRet appendFormat:@"verion: %ld\n\t", (long)_version];
    [strRet appendFormat:@"behalf: %@\n\t", _behalf];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
