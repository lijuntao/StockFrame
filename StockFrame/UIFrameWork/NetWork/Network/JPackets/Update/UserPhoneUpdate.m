//
//  UserPhoneUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/21.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "UserPhoneUpdate.h"

@implementation UserPhoneUpdate
- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _txid = dict[@(2)];
    _user = dict[@(3)];
    _phone = dict[@(4)];
    _err = dict[@(5)];
    _msg = dict[@(6)];
}
@end
