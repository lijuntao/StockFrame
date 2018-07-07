//
//  SymbolChangedUpdate.m
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/9/1.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "SymbolChangedUpdate.h"

@implementation SymbolChangedUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _market = nil;
        _action = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _market = [dict objectForKey:@(2)];
    _action = [dict objectForKey:@(3)];
    
}

@end
