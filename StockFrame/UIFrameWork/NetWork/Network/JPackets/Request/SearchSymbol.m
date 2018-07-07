//
//  SearchSymbol.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "SearchSymbol.h"

@implementation SearchSymbol
@synthesize dict = _dict;

- (id)initWithUserID:(NSString *)strUserID
               qtype:(EnumSymbolLanguageType)qtype
              market:(NSString *)strMarket
             keyword:(NSString *)strKeyword
                page:(NSNumber *)numPage
             sympage:(NSNumber *)numPerPage
                txid:(NSString *)strTXID
            category:(EnumSearchSymbolCat)cat
{
    self = [super init];
    if (self)
    {
        self.pt = EnumPacketPT_SearchSymbol;
        self.seq = [JPacketSendBase getSeqIncreased];
        _user = strUserID;
        _qtype = qtype;
        _market = strMarket;
        _keyword = strKeyword;
        _page = numPage;
        _sympage = numPerPage;
        _txid = strTXID;
        _category = cat;
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        [dict setObject:@(qtype) forKey:@(3)];
        [dict setObject:strMarket forKey:@(4)];
        [dict setObject:strKeyword forKey:@(5)];
        [dict setObject:numPage forKey:@(6)];
        [dict setObject:numPerPage forKey:@(7)];
        [dict setObject:strTXID forKey:@(8)];
        
        if (cat != EnumSearchSymbolCat_None)
            [dict setObject:@(cat) forKey:@(9)];
        
        _dict = (NSDictionary *)dict;
        
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: SearchSymbol (%d)\n\t", EnumPacketPT_SearchSymbol];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"type: %d\n\t", _qtype];
    [strRet appendFormat:@"market: %@\n\t", _market];
    [strRet appendFormat:@"keyword: %@\n\t", _keyword];
    [strRet appendFormat:@"page: %@\n\t", _page];
    [strRet appendFormat:@"sympage: %@\n\t", _sympage]; 
    [strRet appendFormat:@"txid: %@\n\t", _txid];
    [strRet appendFormat:@"category: %d\n\t", _category];
    
    [strRet appendString:@"\n}\n"];
    return strRet;
}

@end
