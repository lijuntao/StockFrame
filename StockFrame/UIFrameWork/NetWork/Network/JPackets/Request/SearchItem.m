//
//  SearchItem.m
//  MasterDataManager
//
//  Created by ljt on 2017/9/18.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "SearchItem.h"

@interface SearchItem ()

@property (strong, nonatomic) NSDictionary *convertDic;

@end

@implementation SearchItem
@synthesize dict = _dict;

- (id)initWithItemDic:(NSDictionary *)itemDic {
    if (self = [super init]) {
        self.pt = EnumPacketPT_SearchItem;
        self.seq = [JPacketSendBase getSeqIncreased];
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        
        _convertDic = @{ @"hktype":@(3),
                                      @"filter":@(4),
                                      @"side":@(5),
                                      @"underlying":@(6),
                                      @"inOut":@(7),
                                      @"maturity":@(8),
                                      @"vendor":@(9),
                                      @"orderby":@(10),
                                      @"desc":@(11),
                                      @"page":@(12),
                                      @"size":@(13)};
        NSArray *keys = itemDic.allKeys;
        for (NSString *key in keys) {
            if ([_convertDic.allKeys containsObject:key]) {
                [dict setObject:itemDic[key] forKey:_convertDic[key]];
            }
        }
        _dict = dict;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: %@ (%d)\n\t",NSStringFromClass(self.class) ,self.pt];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    NSArray *keys = _dict.allKeys;
    
    for (id key in keys) {
        if (((NSNumber *)key).integerValue ==1 || ((NSNumber *)key).integerValue == 2) { //pt seq 不打印
            continue;
        }
        NSString *strKey = @"";
        for (int i = 0; i < self.convertDic.allKeys.count; i++) {
            NSString *tmpKey = [self.convertDic.allKeys objectAtIndex:i];
            NSNumber *tmpKalue = [self.convertDic objectForKey:tmpKey];
            if (tmpKalue.integerValue == ((NSNumber *)key).integerValue) {
                strKey = tmpKey;
                break;
            }
        }
        [strRet appendFormat:@"%@: %@\n\t", strKey,_dict[key]];
    }
    
    [strRet appendString:@"\n}\n"];
    return strRet;
}

@end
