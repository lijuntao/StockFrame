//
//  GlobalSettingUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/12/21.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "GlobalSettingUpdate.h"

@implementation GlobalSettingUpdate

@synthesize market = _market;
@synthesize initac = _initac;
@synthesize mgntimes = _mgntimes;
@synthesize mgncut = _mgncut;
@synthesize mgncall = _mgncall;
@synthesize cdpartial = _cdpartial;
@synthesize appset = _appset;

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _market = [dict objectForKey:@(2)];
    _initac = [dict objectForKey:@(3)];
    _mgntimes = [dict objectForKey:@(4)];
    _mgncut = [dict objectForKey:@(5)];
    _mgncall = [dict objectForKey:@(6)];
    _cdpartial= [dict objectForKey:@(7)];
    _appset = [dict objectForKey:@(8)];
}


@end
