//
//  FDTOCTools.m
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import "FDTOCTools.h"
#import "FDTDataFormatter.h"
@implementation FDTOCTools
+ (EnumSymbolLanguageType)getDeviceLanguage{
    return CN;
}

+ (NSString *) getStringFromEnumChartPeriod:(EnumChartPeriod)period {
    NSString *result = @"";
    switch (period) {
        case OneMin:
            result = @"1H";
            break;
        case FiveMin:
            result = @"1D";
            break;
        case FifteenMin:
            result = @"1W";
            break;
        case SixtyMin:
            result = @"1M";
            break;
        case OneDay:
            result = @"3M";
            break;
        case OneWeek:
            result = @"1Y";
            break;
        case OneMonth:
            result = @"5Y";
            break;
        case DC:
            result = @"DC";
        default:
            break;
    }
    return result;
}

+ (EnumChartPeriod)getEnumChartPeriodFromString:(NSString *)period {
    if ([period isEqualToString:@"DC"]) {
        return DC;
    } else {
        return OneMin;
    }
}

+ (BOOL)timeIsInSession:(NSString *)time withSession:(NSString *)session {
    //目标时间为 0930形式，后面加00补全为 093000形式
    NSString *targetTime = [NSString stringWithFormat:@"%@00", time];
    NSArray *sessions = [session componentsSeparatedByString:@","];
    for (NSString *sessionItem in sessions) {
        NSArray *subSessions = [sessionItem componentsSeparatedByString:@"-"];
        NSString *startTime = subSessions.firstObject;
        NSString *endTime = subSessions.lastObject;
        return [FDTOCTools timeIsInInterval:targetTime startTime:startTime endTime:endTime];
    }
    return false;
}

+ (BOOL)timeIsInInterval:(NSString *)time startTime:(NSString *)startTime endTime:(NSString *)endTime {
    NSString *newTime = [NSString stringWithFormat:@"2000-01-01 %@",time];
    NSDateFormatter *dateFormatter = [[FDTDataFormatter sharedInstance] getHHmmss];
    NSDate *nowDate = [dateFormatter dateFromString:newTime];
    
    NSString *newStartTime = [NSString stringWithFormat:@"2000-01-01 %@",startTime];
    NSString *newEndTime = [NSString stringWithFormat:@"2000-01-01 %@",endTime];
    dateFormatter = [[FDTDataFormatter sharedInstance] getColonHHmmss];
    NSDate *startDate = [dateFormatter dateFromString:newStartTime];
    NSDate *endDate = [dateFormatter dateFromString:newEndTime];
    
    if ([nowDate isEqualToDate:startDate] ||
        [nowDate isEqualToDate:endDate] ||
        ([nowDate laterDate:startDate] &&
         [nowDate earlierDate:endDate])) {
            return true;
    }
    return false;
}

+ (NSInteger)countMinInSession:(NSString *)session {
    NSInteger count = 0;
    NSArray *sessions = [session componentsSeparatedByString:@","];
    for (NSString *sessionItem in sessions) {
        NSArray *subSessions = [sessionItem componentsSeparatedByString:@"-"];
        NSString *startTime = subSessions.firstObject;
        NSString *endTime = subSessions.lastObject;
        NSString *newStartTime = [NSString stringWithFormat:@"2000-01-01 %@",startTime];
        NSString *newEndTime = [NSString stringWithFormat:@"2000-01-01 %@",endTime];
        NSDateFormatter *dateFormatter = [[FDTDataFormatter sharedInstance] getColonHHmmss];
        NSDate *startDate = [dateFormatter dateFromString:newStartTime];
        NSDate *endDate = [dateFormatter dateFromString:newEndTime];
        count += [endDate timeIntervalSinceDate:startDate] / 60.0;
        count += 1;
    }
    return count;
}
@end
