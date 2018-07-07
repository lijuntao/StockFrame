//
//  WmGetTradeHistoryUpdate.m
//  MasterDataManager
//
//  Created by 姚晨峰 on 2017/5/2.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "WmGetTradeHistoryUpdate.h"
@implementation WmGetTradeHistoryUpdate
- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    self.user = [dict objectForKey:@(2)];
    self.account = [dict objectForKey:@(4)];
    self.start_date = [dict objectForKey:@(5)];
    self.end_date = [dict objectForKey:@(6)];
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *oArr = [dict objectForKey:@(3)];
//    for (NSDictionary *dictData in oArr) {
//        WmTradeUpdateCore *core = [WmTradeUpdateCore new];
//        core.sym = dictData[@1];
//        core.price = dictData[@2];
//        core.qty = dictData[@3];
//        core.ostatus = [dictData[@4] intValue];
//        core.Id = dictData[@5];
//        core.order_type = [dictData[@6] intValue];
//        core.time = dictData[@9];
//        [arr addObject:core];
//    }
    
    for (NSDictionary *dictData in oArr)
    {
        WmTradeItem *core = [WmTradeItem new];
        core.sym = dictData[@1];
        core.price = dictData[@2];
        core.qty = dictData[@3];
        core.ostatus = EnumOrderStatus_DONE_FOR_DAY;
//        core.ostatus = [dictData[@4] intValue];
        NSString *tradeDate = dictData[@6];
        core.Id = dictData[@4];
        core.order_type = [dictData[@5] intValue];
        core.exchange = dictData[@7];
        core.time = tradeDate;
        [arr addObject:core];
    }

    
    self.d = arr;
}

@end
