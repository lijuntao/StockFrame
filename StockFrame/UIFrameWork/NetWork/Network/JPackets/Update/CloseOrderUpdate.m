//
//  CloseOrderUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "CloseOrderUpdate.h"

@implementation CloseOrderUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _account = nil;
        _symbol = nil;
        _err = nil;
        _msg = nil;
        _txid = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _account = [dict objectForKey:@(2)];
    _symbol = [dict objectForKey:@(3)];
    _err = [dict objectForKey:@(4)];
    _msg = [dict objectForKey:@(5)];
    _txid = [dict objectForKey:@(6)];
    
}
@end
