//
//  ClosedPositionUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface ClosedPositionUpdateCore : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *sym;
@property (nonatomic, strong) NSDecimalNumber *pl;
@property (nonatomic, strong) NSString *sell;
@property (nonatomic, strong) NSString *buy;
@property (nonatomic, strong) NSDecimalNumber *qty;
@property (nonatomic, strong) NSDecimalNumber *acpl;

@end

@interface ClosedPositionUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSArray *closedPos;

@end
