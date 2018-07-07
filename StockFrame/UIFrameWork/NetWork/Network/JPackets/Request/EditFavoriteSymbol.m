//
//  EditFavoriteSymbol.m
//  MasterDataManager
//
//  Created by ljt on 2017/11/8.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "EditFavoriteSymbol.h"
@interface EditFavoriteSymbol ()

@property (nonatomic, strong) NSString *market;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSDictionary *groupDic;

@end

@implementation EditFavoriteSymbol
@synthesize dict = _dict;

- (id)initWithTags:(NSArray *)tagsArray groupDic:(NSDictionary *)groupDic {
    if (self == [super init]) {
        self.pt = EnumPacketPT_EditFavoriteSymbol;
        self.seq = [JPacketSendBase getSeqIncreased];
        self.tags = tagsArray;
        self.groupDic = groupDic;
        self.market = @"WM";
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:self.market forKey:@(3)];

        NSMutableArray *symbolsArray = [NSMutableArray new];
        
        NSArray *allSymbols = [self.groupDic objectForKey:@"FDT_WM_ALL"]; //所有的Symbol名单
        for (NSString *obj in allSymbols) {
            NSMutableDictionary *symbolsDic = [NSMutableDictionary new];
            [symbolsDic setObject:obj forKey:@(1)];
            
            NSMutableArray *tagsArray = [NSMutableArray new];
            
            NSArray *groupKeys = self.groupDic.allKeys;
            
            for (NSString *key in groupKeys) {
                //如果是系统分组 跳过
                if ([key isEqualToString:@"FDT_WM_ALL"] ||
                    [key isEqualToString:@"FDT_WM_HK"] ||
                    [key isEqualToString:@"FDT_WM_US"] ||
                    [key isEqualToString:@"FDT_WM_CN"]) {
                    continue;
                }
                NSArray *groupValues = self.groupDic[key];
                NSMutableDictionary *tag = [NSMutableDictionary new];
                for (NSString *symbol in groupValues) {
                    if ([symbol isEqualToString:obj]) {
                        [tag setObject:key forKey:@(1)];
//                        break;
                    }
                }
                if (tag.count > 0) {
                    [tagsArray addObject:tag];
                }
            }
            
            
            if (tagsArray.count > 0) {
                [symbolsDic setObject:tagsArray forKey:@(2)];
            } else {
                [symbolsDic setObject:@[] forKey:@(2)];
            }
            [symbolsArray addObject:symbolsDic];
        }
        
        [dict setObject:symbolsArray forKey:@(4)];

        NSMutableArray *tags = [NSMutableArray new];
        for (NSString *obj in self.tags) {
            //如果是系统分组 跳过
            if ([obj isEqualToString:@"FDT_WM_ALL"] ||
                [obj isEqualToString:@"FDT_WM_HK"] ||
                [obj isEqualToString:@"FDT_WM_US"] ||
                [obj isEqualToString:@"FDT_WM_CN"]) {
                continue;
            }
            NSMutableDictionary *tagsDict = [NSMutableDictionary new];
            [tagsDict setObject:obj forKey:@(1)];
            [tags addObject:tagsDict];
        }
        [dict setObject:tags forKey:@(5)];
        
        _dict = dict;
    }
    return self;
}

- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: EditFavoriteSymbol (%d)\n\t", EnumPacketPT_EditFavoriteSymbol];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    [strRet appendFormat:@"content: %@\n\t", _dict];
    [strRet appendString:@"\n}\n"];
    
    return strRet;
}
@end
