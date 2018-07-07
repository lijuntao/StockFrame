//
//  GetFavoriteSymbol.m
//  MasterDataManager
//
//  Created by ljt on 2017/11/7.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "GetFavoriteSymbol.h"

@interface GetFavoriteSymbol ()

@property (nonatomic, strong) NSString *market;

@end

@implementation GetFavoriteSymbol
@synthesize dict = _dict;

- (id)initWithMarket:(NSString *)market {
    if (self == [super init]) {
        self.pt = EnumPacketPT_GetFavoriteSymbol;
        self.seq = [JPacketSendBase getSeqIncreased];
        self.market = market;
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        if (market) {
            [dict setObject:market forKey:@(3)];
        }
        _dict = dict;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: GetFavoriteSymbol (%d)\n\t", EnumPacketPT_GetFavoriteSymbol];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"market: %@\n\t", _market];
    
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
