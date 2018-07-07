//
//  WmGetOrderHistoryUpdate.m
//  MasterDataManager
//
//  Created by 姚晨峰 on 2017/4/28.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "WmGetOrderHistoryUpdate.h"

@implementation WmGetOrderHistoryUpdate
- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    self.user = [dict objectForKey:@(2)];
    self.account = [dict objectForKey:@(4)];
    self.start_date = [dict objectForKey:@(5)];
    self.end_date = [dict objectForKey:@(6)];
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *oArr = [dict objectForKey:@(3)];
    for (NSDictionary *dictData in oArr) {
        WmOrderItem *core = [WmOrderItem new];
        core.sym = dictData[@1];
        core.price = dictData[@2];
        if(core.price.floatValue == 0){
            core.price = nil;
        }
        core.qty = dictData[@3];
        core.ostatus = [dictData[@4] intValue];
        core.Id = dictData[@5];
        core.order_type = [dictData[@6] intValue];
        NSString *tradeDate = dictData[@21];
        core.fillqty = dictData[@10];
        core.time = [NSString stringWithFormat:@"%@ %@",tradeDate,dictData[@9]];
        [arr addObject:core];
    }
   
    self.d = arr;
}

@end

