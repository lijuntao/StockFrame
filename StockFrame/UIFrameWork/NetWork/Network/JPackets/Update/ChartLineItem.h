//
//  TickLineItem.h
//  MasterDataManager
//
//  Created by Rick on 2014/5/27.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPacketDef.h"

@interface ChartLineItem : NSObject <NSCopying,NSCoding, NSMutableCopying>

@property (nonatomic, strong) NSNumber *trddate;   // eg: 20160613 交易日 如果夜盘则交易日为次日；如果周五夜盘，则为下周一
@property (nonatomic, strong) NSNumber *yyyymmdd;  // eg: 20160613 数据日期所在的实际日期
@property (nonatomic, strong) NSNumber *hhmm;      // eg: 933 (09:33)
@property (nonatomic, strong) NSNumber *close;
//@property (nonatomic, strong) NSNumber *volume;
@property (nonatomic, strong) NSString *dataTime;  // eg: 933 (09:33) 和hhmm只是类型不同
@property (nonatomic, strong) NSString *volumeStr; // eg: 470239
@property (nonatomic, strong) NSDecimalNumber *avgPX;

// US 只有美股时有效
@property (nonatomic, strong) NSNumber *ori_yyyymmdd;  // eg: 20160613 数据日期所在的实际日期
@property (nonatomic, strong) NSNumber *ori_hhmm;      // eg: 933 (09:33)

- (void)encodeWithCoder:(NSCoder *)encoder;

- (NSString *)chartDate;
- (NSString *)chartTradeDate;

@end