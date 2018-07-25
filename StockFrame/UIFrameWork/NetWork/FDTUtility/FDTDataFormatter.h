//
//  FDTDataFormatter.h
//  StockFrame
//
//  Created by fdt on 2018/7/25.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDTDataFormatter : NSObject
+ (instancetype)sharedInstance;
- (NSDateFormatter *)getHHmmss;
- (NSDateFormatter *)getColonHHmmss;
@end
