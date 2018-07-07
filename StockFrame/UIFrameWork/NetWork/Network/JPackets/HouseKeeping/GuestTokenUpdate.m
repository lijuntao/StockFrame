//
//  GuestTokenUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "GuestTokenUpdate.h"

@implementation GuestTokenUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _token = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _token = [dict objectForKey:@(2)]; 
    
}
@end
