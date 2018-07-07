//
//  WmCalculateOrderUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/6/17.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmCalculateOrderUpdate.h"

@implementation WmCalculateOrderUpdate

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _currency = [dict objectForKey:@(2)];
    _sym = [dict objectForKey:@(3)];
    _order_type = [[dict objectForKey:@(4)] intValue];
    _price = [dict objectForKey:@(5)];
    _qty = [dict objectForKey:@(6)];
    _ccas = [dict objectForKey:@(7)];
    _commission = [dict objectForKey:@(8)];
    _stampduty = [dict objectForKey:@(9)];
    _levy = [dict objectForKey:@(10)];
    _total = [dict objectForKey:@(11)];
    _amount = [dict objectForKey:@(12)];
}
@end
