//
//  NSString+FDT.h
//  StockFrame
//
//  Created by fdt on 2018/7/5.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FDT)

+ (BOOL)isNilOrEmpty:(NSString *)string;
- (BOOL)isEmpty;
- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace;
- (NSString *)stringByTrimmingWhitespace;
@end
