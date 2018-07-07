//
//  WmSmsLoginUpdate.m
//  MasterDataManager
//
//  Created by 姚晨峰 on 2017/5/15.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "WmSmsLoginUpdate.h"

@implementation WmSmsLoginUpdate
- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    _err = [dict objectForKey:@(3)];
    _msg = [dict objectForKey:@(4)];
    _phone = [dict objectForKey:@(5)];
    _sms_token = [dict objectForKey:@(6)];
    _expire = [dict objectForKey:@(7)];
}
@end
