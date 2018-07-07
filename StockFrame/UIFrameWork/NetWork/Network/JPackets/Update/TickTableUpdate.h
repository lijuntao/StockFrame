//
//  TickTableUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface TickRangeValueSet : NSObject

@property (nonatomic, strong) NSDecimalNumber *range;
@property (nonatomic, strong) NSDecimalNumber *delta;

@end

@interface TickTableUpdateRule : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSArray *valueSet;    // lots of TickRangeValueSet

@end

@interface TickTableUpdate : JPacketReceiveBase
 
@property (nonatomic, strong) NSString *err;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSArray *d;       // lots of TickTableUpdateRule

@end
