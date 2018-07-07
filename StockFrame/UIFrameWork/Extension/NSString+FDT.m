//
//  NSString+FDT.m
//  StockFrame
//
//  Created by fdt on 2018/7/5.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import "NSString+FDT.h"

@implementation NSString (FDT)

+ (BOOL)isNilOrEmpty:(NSString *)string
{
    if (!string || ![string isKindOfClass:[NSString class]] || [string isEmpty]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isEmpty
{
    return [self isEmptyIgnoringWhitespace:YES];
}

- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace
{
    NSString *toCheck = ignoreWhitespace ? [self stringByTrimmingWhitespace] : self;
    return [toCheck isEqualToString:@""];
}

- (NSString *)stringByTrimmingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
@end
