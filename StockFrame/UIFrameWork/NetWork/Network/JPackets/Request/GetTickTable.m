//
//  GetTickTable.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "GetTickTable.h"

@implementation GetTickTable
@synthesize dict = _dict;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_GetTickTable;
        self.seq = [JPacketSendBase getSeqIncreased];
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetTickTable (%d)\n\t", EnumPacketPT_GetTickTable];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}

@end
