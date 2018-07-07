//
//  ErrorStatus.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "ErrorStatus.h"

@implementation ErrorStatus


- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _err = [dict objectForKey:@(2)];
    _msg = [dict objectForKey:@(3)];
}

@end
