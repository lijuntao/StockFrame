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
+ (NSString *)getEnumChartPeriod:(EnumChartPeriod)period;

@end
