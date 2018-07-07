//
//  GetQuote.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "GetQuote.h"

@implementation GetQuote

@synthesize dict = _dict;

- (instancetype)initWithSymbolIDs:(NSString *)symbolIDs fields:(NSString *)fields
{
    if (self = [super init])
    {
        self.pt = EnumPacketPT_GetQuote;
        self.seq = [JPacketSendBase getSeqIncreased];
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        _symbolIDs = symbolIDs;
        if (_symbolIDs)
            [dict setObject:_symbolIDs forKey:@(3)];
        
        _fields = fields;
        if (_fields)
            [dict setObject:_fields forKey:@(4)];
        
        _dict = (NSDictionary *)dict;
    }
    
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetQuote (%d)\n\t", EnumPacketPT_GetQuote];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    if (_symbolIDs)
        [strRet appendFormat:@"id: %@\n\t", _symbolIDs];
    
    if (_fields)
        [strRet appendFormat:@"field: %@\n\t", _fields];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
