//
//  LookUpSymbol.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "LookUpSymbol.h"

@implementation LookUpSymbol
@synthesize dict = _dict;

- (id)initWithSymbolIDs:(NSArray *)arrSymbolID
                 market:(NSString *)strMarket
                   txid:(NSString *)strTXID
                  qtype:(EnumSymbolLanguageType)qtype
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_LookupSymbol;
        self.seq = [JPacketSendBase getSeqIncreased];
        _market = strMarket;
        _txid = strTXID;
        _d = arrSymbolID;
        _qtype = qtype;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:strMarket forKey:@(3)];
        [dict setObject:strTXID forKey:@(4)];
        
        NSMutableArray *arr = [NSMutableArray new];
        for (NSString *strSymbolID in arrSymbolID)
        {
            [arr addObject:@{@(1):strSymbolID}];
        }
        [dict setObject:arr forKey:@(5)];
        [dict setObject:@(qtype) forKey:@(6)];
        [dict setObject:@(1) forKey:@(7)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: LookupSymbol (%d)\n\t", EnumPacketPT_LookupSymbol];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
      
    [strRet appendFormat:@"market: %@\n\t", _market];
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendFormat:@"d: %@\n\t", _d];
    [strRet appendFormat:@"qtype: %d\n\t", _qtype];
    
    [strRet appendString:@"\n}\n"];
    return strRet;
}

@end
