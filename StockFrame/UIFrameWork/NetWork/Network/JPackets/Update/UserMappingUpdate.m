//
//  UserMappingUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "UserMappingUpdate.h"

@implementation UserMappingUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _txid = nil;
        _user = nil;
        _user_3rd = nil;
        _exist_3rd = NO;
        _exist_user = NO;
        _market = nil;
        _language = nil;
        _email = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _txid = [dict objectForKey:@(2)];
    if ([dict objectForKey:@(3)])
        _user = [dict objectForKey:@(3)];
    _user_3rd = [dict objectForKey:@(4)];
    _exist_3rd = [[dict objectForKey:@(5)] intValue];
    _exist_user = [[dict objectForKey:@(6)] boolValue];
    _market = [dict objectForKey:@(7)];
    _language = [dict objectForKey:@(8)];
    _email = [dict objectForKey:@(9)];
    
}
@end
