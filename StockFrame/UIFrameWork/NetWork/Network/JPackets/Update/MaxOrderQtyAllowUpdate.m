//
//  GetMaxOrderQtyAllowUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/12/15.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "MaxOrderQtyAllowUpdate.h"

@implementation MaxOrderQtyAllowUpdate


- (id)init
{
    self = [super init];
    if (self)
    {
        _txid = nil;

        _err = nil;
        _msg = nil;

        _market = nil;
        _account = nil;
        _cavailable =  nil;
        _qty = nil;
        
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _market = [dict objectForKey:@(2)];
    _account = [dict objectForKey:@(3)];
    _txid = [dict objectForKey:@(4)];
    _cavailable = [dict objectForKey:@(5)];
    _qty = [dict objectForKey:@(6)];
    _err = [dict objectForKey:@(7)];
    _msg = [dict objectForKey:@(8)];
    
}

/*
 @property (nonatomic, strong) NSString *market;
 @property (nonatomic, strong) NSString *account;
 @property (nonatomic, strong) NSString *txid;
 @property (nonatomic, strong) NSString *cavailable;
 @property (nonatomic, strong) NSString *qty;
 @property (nonatomic, strong) NSString *err;
 @property (nonatomic, strong) NSString *msg;
 */

@end
