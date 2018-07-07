//
//  UserMappingListUpdate.m
//  MasterDataManager
//
//  Created by Jamison Huang on 2015/6/4.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "UserMappingListUpdate.h"

@implementation ThirdPartyUser

- (id)init
{
    self = [super init];
    if (self)
    {
        _thirdPartyID = nil;
        _utype = 0;
    }
    
    return self;
}
@end

@implementation UserMappingListUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        _txid = nil;
        _user = nil;
        _market = nil;
        _language = nil;
        _d = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _txid = [dict objectForKey:@(2)];
    _user = [dict objectForKey:@(3)];
    _market = [dict objectForKey:@(4)];
    _language = [dict objectForKey:@(5)];
    
    NSArray *d = [dict objectForKey:@(6)];
    NSMutableArray *arrParsedData = [NSMutableArray new];
    for (NSDictionary *dictData in d)
    {
        ThirdPartyUser *thirdPartyUser = [ThirdPartyUser new];
        [thirdPartyUser setThirdPartyID:[dictData objectForKey:@(1)]];
        [thirdPartyUser setUtype:[[dictData objectForKey:@(2)] intValue]];
        [arrParsedData addObject:thirdPartyUser];
    }
    
    _d = arrParsedData;
    
}


@end
