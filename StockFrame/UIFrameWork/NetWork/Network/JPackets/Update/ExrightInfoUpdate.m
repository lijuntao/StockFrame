//
//  ExrightInfoUpdate.m
//  MasterDataManager
//
//  Created by fdt on 2017/12/26.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "ExrightInfoUpdate.h"
#import "ExrightInfoItem.h"

@implementation ExrightInfoUpdate

-(id)init {
    self = [super init];
    if (self) {
        _symbol = nil;
        _d = nil;
    }
    return self;
}

-(void)fillData:(NSDictionary *)dict {
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO) {
        return;
    }
    
    _symbol = [dict objectForKey:@(3)];
    NSMutableArray *p = [NSMutableArray new];
    NSArray *a = [dict objectForKey:@(4)];
    for (NSDictionary *d in a){
        ExrightInfoItem *item = [ExrightInfoItem new];
        item.date = [d objectForKey:@(1)];
        item.desc = [d objectForKey:@(2)];
        item.factor = [[NSDecimalNumber alloc] initWithDouble:[[d objectForKey:@(3)] doubleValue]];
        [p addObject:item];
    }
    _d = p;
}

@end
