//
//  NSDecimalNumber+Compare.m
//  MasterDataManager
//
//  Created by doshan on 2014/7/2.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "NSDecimalNumber+Compare.h"

@implementation NSDecimalNumber (Compare)

- (BOOL)isGreaterThan:(NSDecimalNumber *)numTarget
{
    if ([self compare:numTarget] == NSOrderedDescending)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)isGreaterThanOrEuqal:(NSDecimalNumber *)numTarget
{
    if ([self compare:numTarget] == NSOrderedDescending || [self compare:numTarget] == NSOrderedSame)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)isLesserThan:(NSDecimalNumber *)numTarget
{
    if ([self compare:numTarget] == NSOrderedAscending)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)isLesserThanOrEqual:(NSDecimalNumber *)numTarget
{
    if ([self compare:numTarget] == NSOrderedAscending || [self compare:numTarget] == NSOrderedSame)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)isEqualToNSDecimalNumber:(NSDecimalNumber *)numTarget
{
    if ([self compare:numTarget] == NSOrderedSame)
    {
        return YES;
    }
    
    return NO;
}

- (NSDecimalNumber *)abs
{
    if ([self compare:[NSDecimalNumber zero]] == NSOrderedAscending) {
        // Number is negative. Multiply by -1
        NSDecimalNumber *negativeOne = [NSDecimalNumber decimalNumberWithMantissa:1
                                                                         exponent:0
                                                                       isNegative:YES];
        return [self decimalNumberByMultiplyingBy:negativeOne];
    } else {
        return self;
    }
}

@end
