//
//  UnionTokenUpdate.m
//  MasterDataManager
//
//  Created by FDT14009Mac on 2016/1/27.
//  Copyright © 2016年 HKFDT. All rights reserved.
//

#import "UnionTokenUpdate.h"

@implementation UnionToken



@end

@implementation UnionTokenUpdate
@synthesize err = _err;
@synthesize msg = _msg;

- (id)init
{
    self = [super init];
    if (self)
    {
        _err = nil;
        _msg = nil;
        _tokens = nil;
        _isNewUser = false;
    }
    
    return self;
}

- (void)fillData:(NSDictionary *)dict
{
    [super fillData:dict];
    
    if ([dict isKindOfClass:[NSDictionary class]] == NO)
        return;
    
    self.seq = [[dict objectForKey:@(2)] intValue];
    
    
    _err = [self nullFilter:[dict objectForKey:@(3)]];
    _msg = [self nullFilter:[dict objectForKey:@(4)]];

    _isNewUser = [[dict objectForKey:@(6)] boolValue];
    
    if ([dict objectForKey:@(7)]) {
        _fdtid = [self nullFilter:[dict objectForKey:@(7)]];
    }
    
    
    NSArray *arrtokens = [dict objectForKey:@(5)];
    NSMutableArray *arrParsedData = [NSMutableArray new];
    for (NSDictionary *dictData in arrtokens)
    {
        UnionToken *token = [UnionToken new];
        
        [token setMarket:[dictData objectForKey:@(1)]];
        [token setToken:[dictData objectForKey:@(2)]];
        [token setLevel:[dictData objectForKey:@(3)]];
        [token setAsip:[dictData objectForKey:@(4)]];
        [token setAsport:[dictData objectForKey:@(5)]];
        [token setAsport:[dictData objectForKey:@(5)]];
        [token setDefqty:[dictData objectForKey:@(6)]];
        [arrParsedData addObject:token];
    }
    _tokens = arrParsedData;
}
@end
