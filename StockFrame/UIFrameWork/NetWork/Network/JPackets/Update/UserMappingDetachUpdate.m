//
//  UserMappingDetachUpdate.m
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/5/29.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "UserMappingDetachUpdate.h"

@implementation UserMappingDetachUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _txid = nil;
        _user = nil;
        _user_3rd = nil;
        _market = nil;
        _language = nil;
        _err = nil;
        _msg = nil;
        _is_attach = NO;
        _utype = EnumUserRoleType_Normal;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _txid = [dict objectForKey:@(2)];
    _user = [dict objectForKey:@(3)];
    _user_3rd = [dict objectForKey:@(4)];
    _market = [dict objectForKey:@(5)];
    _language = [dict objectForKey:@(6)];
    
    if ([[dict objectForKey:@(7)] isKindOfClass:[NSString class]])
        _err = [dict objectForKey:@(7)];
    
    if ([[dict objectForKey:@(8)] isKindOfClass:[NSString class]])
        _msg = [dict objectForKey:@(8)];
    
    _is_attach = [[dict objectForKey:@(9)] boolValue];
    _utype = [[dict objectForKey:@(10)] intValue];
    
}

@end
