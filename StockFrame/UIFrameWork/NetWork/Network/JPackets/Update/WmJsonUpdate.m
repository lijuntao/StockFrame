//
//  WmJsonUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/7/18.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "WmJsonUpdate.h"

@implementation WmJsonUpdate
- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _param_json = dict[@(2)];
    _json = dict[@(3)];
}
@end
