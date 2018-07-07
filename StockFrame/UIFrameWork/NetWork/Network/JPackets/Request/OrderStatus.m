//
//  OrderStatus.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "OrderStatus.h"

@implementation OrderStatus

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    if ([[dict allKeys] containsObject:@(2)])
        self.seq = [[dict objectForKey:@(2)] intValue];
    
    _orderID = [dict objectForKey:@(3)];
    _err = [dict objectForKey:@(4)];
    _msg = [dict objectForKey:@(5)];
    _account = [dict objectForKey:@(6)];
}
@end
