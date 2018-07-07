//
//  UserMappingDetachStatus.m
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/5/29.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "UserMappingDetachStatus.h"

@implementation UserMappingDetachStatus

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    if ([[dict allKeys] containsObject:@(2)])
        self.seq = [[dict objectForKey:@(2)] intValue];
    
    _err = [dict objectForKey:@(3)];
    _msg = [dict objectForKey:@(4)];
}
@end
