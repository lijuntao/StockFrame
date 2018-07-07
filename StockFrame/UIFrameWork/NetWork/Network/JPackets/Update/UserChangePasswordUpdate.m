//
//  UserChangePasswordUpdate.m
//  MasterDataManager
//
//  Created by 姚晨峰 on 16/8/29.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "UserChangePasswordUpdate.h"

@implementation UserChangePasswordUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _phone = nil;
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
//    self.pt = EnumPacketPT_UserChangePasswordUpdate;
    self.seq = [[dict objectForKey:@(2)] intValue];
    _phone = [dict objectForKey:@(2)];
    _err = [dict objectForKey:@(3)];
    _msg = [dict objectForKey:@(4)];
    
}
@end
