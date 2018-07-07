//
//  GetLightWeightRank.m
//  MasterDataManager
//
//  Created by ljt on 2017/7/24.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "GetLightWeightRank.h"
#import "WmRankingCategoryItem.h"

@implementation GetLightWeightRank
@synthesize dict = _dict;

- (id)initWithType:(NSString *)type
        categories:(NSArray *)categories
         timestamp:(NSInteger)timestamp{
    
    self = [super init];
    if (self) {
        self.pt = EnumPacketPT_GetLightWeightRank;
        self.seq = [JPacketSendBase getSeqIncreased];
        _type = type;
        _categories = categories;
        _timestamp = timestamp;
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@(self.pt) forKey:@(1)];
        [dict setObject:@(self.seq) forKey:@(2)];
        [dict setObject:self.type forKey:@(3)];
        
        NSMutableArray *categoriesArray = [NSMutableArray new];
        @try {
            for (WmRankingCategoryItem *item in categories) {
                NSMutableDictionary *category = [NSMutableDictionary new];
                [category setObject:item.Id forKey:@(1)];
                [category setObject:@(item.level) forKey:@(2)];
                [category setObject:@(item.desc) forKey:@(3)];
                [categoriesArray addObject:category];
            }
            [dict setObject:categoriesArray forKey:@(4)];
        } @catch (NSException *exception) {
            NSLog(@"GetLightWeightRank Packet Error: Properties in WmRankingCategoryItem can not be nil");
            return self;
        } @finally {
            
        }
        //        [dict setObject:@(self.timestamp) forKey:@(5)];
        _dict = (NSDictionary *)dict;
    }
    return self;
}


- (NSString *)description
{
    NSMutableString *strRet = [NSMutableString new];
    [strRet appendString:@"{\n\t"];
    [strRet appendFormat:@"pt: %@ (%d)\n\t",NSStringFromClass(self.class) ,self.pt];
    [strRet appendFormat:@"seq: %ld\n\t", (long)self.seq];
    
    [strRet appendFormat:@"type: %@\n\t", self.type];
    [strRet appendFormat:@"categories\n\t"];
    for (WmRankingCategoryItem *item in self.categories) {
        [strRet appendFormat:@"- %@\n\t", item.description];
    }
    
    [strRet appendFormat:@"timestamp: %ld\n\t", (long)self.timestamp];
    
    [strRet appendString:@"\n}\n"];
    return strRet;
}
@end
