//
//  FDUtility.h
//  StockFrame
//
//  Created by fdt on 2018/7/4.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDUtility : NSObject

+ (short)swapShortEndian:(short)val;
+ (int)swapIntEndian:(int)val;
+ (long long)swapLongLongEndian:(long long)val;
+ (float)swapFloatEndian:(float)val;
+ (double)swapDoubleEndian:(double)val;

@end
