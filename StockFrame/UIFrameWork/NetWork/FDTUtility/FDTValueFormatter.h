//
//  FDTValueFormatter.h
//  MasterCore
//
//  Created by FDT-14005-MAC on 2014/7/21.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDTValueFormatter : NSObject

+ (NSString *)formatToKMBNumber:(NSDecimalNumber *)numVal;
+ (NSString *)formatToKMBNumber:(NSDecimalNumber *)numVal roundMode:(NSRoundingMode)mode scale:(int)scale;
+ (NSString *)formatToChineseAbbrNumber:(NSDecimalNumber *)numVal withComma:(BOOL)bComma;
+ (NSString *)formatToChineseAbbrNumber:(NSDecimalNumber *)numVal withComma:(BOOL)bComma  dataMgr:(id)dataMgr;

+ (NSString *)formatToDecimalFreeDollarNumber:(NSDecimalNumber *)numVal withComma:(BOOL)bComma;
+ (NSString *)formatToDecimalFreeDollarNumber:(NSDecimalNumber *)numVal roundMode:(NSRoundingMode)roundMode withComma:(BOOL)bComma;
+ (NSString *)formatToFixDigitNumber:(NSDecimalNumber *)numVal totalDigit:(int)digit;
+ (NSString *)formatToFixDeciamlNumber:(NSDecimalNumber *)numVal deciamlDigit:(int)digit;
+ (NSString *)formatToWMFXStyle:(NSDecimalNumber *)decimalNumber withDeciamlDigit:(int)digit;

@end
