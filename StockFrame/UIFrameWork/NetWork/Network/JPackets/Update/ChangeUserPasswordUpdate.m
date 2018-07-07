//
//  ChangeUserPasswordUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "ChangeUserPasswordUpdate.h"

@implementation ChangeUserPasswordUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _user = nil;
        _err = nil;
        _msg = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    self.seq = [[dict objectForKey:@(2)] intValue];
    _user = [dict objectForKey:@(3)];
    _err = [dict objectForKey:@(4)];
    _msg = [dict objectForKey:@(5)];
    
}
@end
