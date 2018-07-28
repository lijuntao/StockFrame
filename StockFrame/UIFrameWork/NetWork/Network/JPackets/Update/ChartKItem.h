//
//  TickKItem.h
//  MasterDataManager
//
//  Created by Rick on 2014/5/27.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChartLineItem.h"

@interface ChartKItem : ChartLineItem <NSCopying,NSCoding,NSMutableCopying>

@property (nonatomic, assign) KLINE_MODE mode;

@property (nonatomic, strong) NSNumber *open;  //开盘价
@property (nonatomic, strong) NSNumber *high; //最高价
@property (nonatomic, strong) NSNumber *low; //最低价

@property (nonatomic, strong) NSNumber *forward_close;
@property (nonatomic, strong) NSNumber *forward_open;
@property (nonatomic, strong) NSNumber *forward_high;
@property (nonatomic, strong) NSNumber *forward_low;

@property (nonatomic, strong) NSNumber *backward_close;
@property (nonatomic, strong) NSNumber *backward_open;
@property (nonatomic, strong) NSNumber *backward_high;
@property (nonatomic, strong) NSNumber *backward_low;
/**
 复权信息，周/月K可能存在多个
 */
@property (nonatomic, strong) NSMutableArray *rightInfoDescs;

-(void)applyFactor:(NSDecimalNumber *) factor lastFactor:(NSDecimalNumber *) lastFactor;

@end
