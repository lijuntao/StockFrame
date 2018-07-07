//
//  AttachUnionIdUpdate.m
//  MasterDataManager
//
//  Created by jiangnan on 15/12/29.
//  Copyright © 2015年 HKFDT. All rights reserved.
//

#import "AttachUnionIdUpdate.h"

@implementation AttachUnionIdUpdate

- (id)init
{
    if (self = [super init])
    {
        self.txid = nil;
        self.openid = nil;
        self.unionid = nil;
        self.market = nil;
        self.language = nil;
        self.err = nil;
        self.msg = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    self.txid = [dict objectForKey:@(2)];
    self.openid = [dict objectForKey:@(3)];
    self.unionid = [dict objectForKey:@(4)];
    self.market = [dict objectForKey:@(5)];
    self.language = [dict objectForKey:@(6)];
    self.err = [dict objectForKey:@(7)];
    self.msg = [dict objectForKey:@(8)];
}

@end
