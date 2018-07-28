//
//  FDTOCTools.h
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPacketDef.h"

@interface FDTOCTools : NSObject

+ (EnumSymbolLanguageType)getDeviceLanguage;


/**
 获取实际的chart period

 @param period 枚举
 @return server 所需字符串
 */
+ (NSString *)getStringFromEnumChartPeriod:(EnumChartPeriod)period;


/**
 由server返回的period 返回枚举

 @param period server返回的period
 @return 枚举
 */
+ (EnumChartPeriod)getEnumChartPeriodFromString:(NSString *)period;


/**
 判断时间是否在某个区间

 @param time 目标时间 0930，0931
 @param session 时间区间
        "09:30:00-11:30:00,13:00:00-15:00:00" A股
        "21:30:00-04:00:00" 美股
 @return YES 是 NO 不是
 */
+ (BOOL)timeIsInSession:(NSString *)time
            withSession:(NSString *)session;

/**
 返回时间是否在一段时间内
 
 @param time 093000
 @param startTime 09:30:00
 @param endTime 15:00:00
 @return YES 是 NO 不是
 */
+ (BOOL)timeIsInInterval:(NSString *)time
               startTime:(NSString *)startTime
                 endTime:(NSString *)endTime;


/**
 返回时间间隔的分钟数

 @param session session
 @return 分钟数
 */
+ (NSInteger)countMinInSession:(NSString *)session;
@end
