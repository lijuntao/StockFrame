//
//  GetChart.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GetChart : JPacketSendBase

@property (nonatomic, strong, readonly) NSArray *symbolIDs;
@property (nonatomic, assign, readonly) EnumChartType ctype;
@property (nonatomic, strong, readonly) NSString *freq;
@property (nonatomic, assign, readonly) NSInteger count;
@property (nonatomic, strong, readonly) NSString *period;

@property (nonatomic, assign, readonly) NSNumber *trddate;
@property (nonatomic, assign, readonly) NSNumber *tdate;
@property (nonatomic, assign, readonly) NSNumber *time;

- (id)initWithSymbolIDs:(NSArray *)arrSymbolID
                  ctype:(EnumChartType)ctype
                   freq:(NSString *)strFreq
                 period:(NSString *)strPeriod
                  count:(int)nCount
                trddate:(NSNumber *)trddate
                  tdate:(NSNumber *)tdate
                   time:(NSNumber *)time;

- (id)initWithSymbolIDs:(NSArray *)arrSymbolID
                  ctype:(EnumChartType)ctype
                   freq:(NSString *)strFreq
                 period:(NSString *)strPeriod
                  count:(int)count;
@end
