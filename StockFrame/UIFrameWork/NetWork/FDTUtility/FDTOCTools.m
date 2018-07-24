//
//  FDTOCTools.m
//  StockFrame
//
//  Created by fdt on 2018/7/19.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import "FDTOCTools.h"

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
@end
