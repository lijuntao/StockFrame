//
//  MarketStatusUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"

@interface MarketStatusUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *ex;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *sesname;

@end
