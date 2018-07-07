//
//  TokenUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "TokenUpdate.h"

@implementation TokenUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _err = nil;
        _msg = nil;
        _token = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    self.seq = [[dict objectForKey:@(2)] intValue];
    _err = [dict objectForKey:@(3)];
    _msg = [dict objectForKey:@(4)];
    _token = [dict objectForKey:@(5)];
    
}
@end
