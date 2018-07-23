//
//  NSDecimalNumber+Compare.h
//  MasterDataManager
//
//  Created by doshan on 2014/7/2.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (Compare)

- (BOOL)isGreaterThan:(NSDecimalNumber *)numTarget;
- (BOOL)isGreaterThanOrEuqal:(NSDecimalNumber *)numTarget;
- (BOOL)isLesserThan:(NSDecimalNumber *)numTarget;
- (BOOL)isLesserThanOrEqual:(NSDecimalNumber *)numTarget;
- (BOOL)isEqualToNSDecimalNumber:(NSDecimalNumber *)numTarget;
- (NSDecimalNumber *)abs;

@end
