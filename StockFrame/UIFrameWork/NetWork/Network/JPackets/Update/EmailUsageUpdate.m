//
//  EmailUsageUpdate.m
//  MasterDataManager
//
//  Created by jiangnan on 15/11/24.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "EmailUsageUpdate.h"

@implementation EmailUsageUpdate

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
    
    _email = [dict objectForKey:@(3)];
    _is_used = [[dict objectForKey:@(4)] boolValue];
}


@end
