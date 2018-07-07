//
//  PhoneUsageUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/7/21.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "PhoneUsageUpdate.h"

@implementation PhoneUsageUpdate
- (id)init
{
    self = [super init];
    if (self)
    {
        _txid = nil;
        _is_used = false;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _txid = [dict objectForKey:@(2)];

    _phone = [dict objectForKey:@(3)];
    _is_used = [[dict objectForKey:@(4)] boolValue];
    _user = [dict objectForKey:@(5)];
}

@end
