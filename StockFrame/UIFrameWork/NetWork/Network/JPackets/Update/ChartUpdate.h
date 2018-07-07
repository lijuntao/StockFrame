//
//  ChartUpdate.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"


@interface ChartUpdate : JPacketReceiveBase

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, assign) NSInteger ctype;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *freq;
@property (nonatomic, strong) NSString *period;
@property (nonatomic, assign) NSInteger sn;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSArray *d;   // ChartUpdateLineData or ChartUpdateKData
@property (nonatomic, strong) NSString *session;
@end