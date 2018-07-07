//
//  UserUpdate.m
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "UserUpdate.h"

@implementation UserUpdateAccount

- (id)init
{
    self = [super init];
    if (self)
    {
        _accountID = nil;
        _ct = nil;
    }
    
    return self;
}
@end

@implementation UserUpdate

@synthesize type = _type;
@synthesize user = _user;
@synthesize err = _err;
@synthesize msg = _msg;
@synthesize name = _name;
@synthesize email = _email;
@synthesize def = _def;
@synthesize utype = _utype;
@synthesize ct = _ct;
@synthesize lt = _lt;
@synthesize d = _d;
@synthesize token = _token;

- (id)init
{
    self = [super init];
    if (self)
    {
        
        _type = JPacket_INVALID;
        _user = nil;
        _err = nil;
        _msg = nil;
        _name = nil;
        _email = nil;
        _def = nil;
        _utype = EnumUserRoleType_INVALID;
        _ct = nil;
        _lt = nil;
        _d = nil;
        _token = nil;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    _type = [[dict objectForKey:@(2)] intValue];
    _user = [dict objectForKey:@(3)];
    _err = [dict objectForKey:@(4)];
    _msg = [dict objectForKey:@(5)];
    _name = [dict objectForKey:@(6)];
    _email= [dict objectForKey:@(7)];
    _def = [dict objectForKey:@(8)];
    if ([[dict allKeys] containsObject:@(9)])
        _utype = [[dict objectForKey:@(9)] intValue];
    _ct = [dict objectForKey:@(10)];
    _lt = [dict objectForKey:@(11)];
    
    NSArray *d = [dict objectForKey:@(12)];
    NSMutableArray *arrParsedData = [NSMutableArray new];
    for (NSDictionary *dictData in d)
    {
        UserUpdateAccount *account = [UserUpdateAccount new];
        
        [account setAccountID:[dictData objectForKey:@(1)]];
        [account setCt:[dictData objectForKey:@(2)]];
        
        [arrParsedData addObject:account];
    }
    
    _d = arrParsedData;
    
    _token = [dict objectForKey:@(13)];
}
@end
