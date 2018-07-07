//
//  AccountResetUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "AccountStateUpdate.h"

@implementation AccountStateUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _user = nil;
        _account = nil;
        _state = EnumAccountState_Normal;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _user = [dict objectForKey:@(2)];
    _account = [dict objectForKey:@(3)];
    if ([dict objectForKey:@(4)])
        _state = [[dict objectForKey:@(4)] intValue];
    
}
@end
