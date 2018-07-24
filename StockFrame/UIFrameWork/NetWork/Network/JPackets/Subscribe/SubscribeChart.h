//
//  SubscribeChart.h
//  MasterDataManager
//
//  Created by JosephChen on 2014/9/30.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface SubscribeChart : JPacketSendBase


//@property (nonatomic, assign, readonly) NSInteger seq;
@property (nonatomic, strong, readonly) NSArray *refSymbolIDs;
@property (nonatomic, strong, readonly) NSArray *unrefSymbolIDs;
@property (nonatomic, assign, readonly) BOOL clearAll;
@property (nonatomic, assign, readonly) EnumChartType ctype;
@property (nonatomic, strong, readonly) NSString *freq;
@property (nonatomic, strong, readonly) NSString *period;
@property (nonatomic, assign, readonly) NSInteger count;
@property (nonatomic, assign, readonly) NSNumber *trddate;
@property (nonatomic, assign, readonly) NSNumber *tdate;
@property (nonatomic, assign, readonly) NSNumber *time;

@property (nonatomic, assign, readonly) NSString *strSubribe;

- (id)initWithRefSymbolIDs:(NSArray *)arrRefSymbolID
            unrefSymbolIDs:(NSArray *)arrUnrefSymbolID
                  clearAll:(BOOL)bClearAll
                     ctype:(EnumChartType)ctype
                      freq:(NSString *)strFreq
                    period:(NSString *)strPeriod
                     count:(NSInteger)nCount
                   trddate:(NSNumber *)trddate
                     tdate:(NSNumber *)tdate
                      time:(NSNumber *)time;
@end
