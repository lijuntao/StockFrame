//
//  FDTValueFormatter.m
//  MasterCore
//
//  Created by FDT-14005-MAC on 2014/7/21.
//  Copyright (c) 2014年 HKFDT. All rights reserved.
//

#import "FDTValueFormatter.h"
#import "NSDecimalNumber+Compare.h"
#import "DataManagerDefinition.h"
#import "FDTOCTools.h"
#define PL_DIGIT 2

@implementation FDTValueFormatter

// K M B 格式
+ (NSString *)formatToKMBNumber:(NSDecimalNumber *)numVal
{
    if (numVal == nil)
        numVal = [[NSDecimalNumber alloc] initWithDouble:0.0];
    if (numVal == [NSDecimalNumber notANumber])
        numVal = [[NSDecimalNumber alloc] initWithDouble:0.0];
    
    
    NSDecimalNumber *numDecimal = numVal;//[[NSDecimalNumber alloc] initWithString:strVal];
    NSString *strRet = [numVal stringValue];
    
    // (nVal > -1000.0 && nVal < 1000.0)
    if ([numDecimal isGreaterThan:[[NSDecimalNumber alloc] initWithString:@"-1000.0"]] &&
        [numDecimal isLesserThan:[[NSDecimalNumber alloc] initWithString:@"1000.0"]])
    {
        NSDecimalNumber *numDiv = [[NSDecimalNumber alloc] initWithString:@"1"];
        
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        numDecimal = [numDecimal decimalNumberByDividingBy:numDiv withBehavior:behavior];
        
        // Decimal zero
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMinimumIntegerDigits:1];
        NSString *numberAsString = [numberFormatter stringFromNumber:numDecimal];
        strRet = [NSString stringWithFormat:@"%@", numberAsString];
        
        return strRet;
    }
    
    // (nVal > -1000000.0 && nVal < 1000000.0)
    else if ([numDecimal isGreaterThan:[[NSDecimalNumber alloc] initWithString:@"-1000000.0"]] &&
             [numDecimal isLesserThan:[[NSDecimalNumber alloc] initWithString:@"1000000.0"]])
    {
        NSDecimalNumber *numDiv = [[NSDecimalNumber alloc] initWithString:@"1000"];
        
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        numDecimal = [numDecimal decimalNumberByDividingBy:numDiv withBehavior:behavior];
        
        // Decimal zero
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMaximumFractionDigits:PL_DIGIT];   // <-- Max
        NSString *numberAsString = [numberFormatter stringFromNumber:numDecimal];
        strRet = [NSString stringWithFormat:@"%@K", numberAsString];
        
    }
    // (nVal > -1000000000.0 && nVal < 1000000000.0)
    else if ([numDecimal isGreaterThan:[[NSDecimalNumber alloc] initWithString:@"-1000000000.0"]] &&
             [numDecimal isLesserThan:[[NSDecimalNumber alloc] initWithString:@"1000000000.0"]])
    {
        NSDecimalNumber *numDiv = [[NSDecimalNumber alloc] initWithString:@"1000000"];
        
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        numDecimal = [numDecimal decimalNumberByDividingBy:numDiv withBehavior:behavior];
        
        // Decimal zero
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMaximumFractionDigits:PL_DIGIT];
        NSString *numberAsString = [numberFormatter stringFromNumber:numDecimal];
        strRet = [NSString stringWithFormat:@"%@M", numberAsString];
    }
    // (nVal > -1000000000000.0 && nVal < 1000000000000.0)
    else if ([numDecimal isGreaterThan:[[NSDecimalNumber alloc] initWithString:@"-1000000000000.0"]]&&
             [numDecimal isLesserThan:[[NSDecimalNumber alloc] initWithString:@"1000000000000.0"]])
    {
        NSDecimalNumber *numDiv = [[NSDecimalNumber alloc] initWithString:@"1000000000"];
        
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        numDecimal = [numDecimal decimalNumberByDividingBy:numDiv withBehavior:behavior];
        
        // Decimal zero
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMaximumFractionDigits:PL_DIGIT];
        NSString *numberAsString = [numberFormatter stringFromNumber:numDecimal];
        strRet = [NSString stringWithFormat:@"%@B", numberAsString];
    }
    return strRet;
}

// K M B 格式 (無條件捨去到小數第一位)
+ (NSString *)formatToKMBNumber:(NSDecimalNumber *)numVal roundMode:(NSRoundingMode)mode scale:(int)scale
{
    if (numVal == nil)
        numVal = [[NSDecimalNumber alloc] initWithDouble:0.0];
    if (numVal == [NSDecimalNumber notANumber])
        numVal = [[NSDecimalNumber alloc] initWithDouble:0.0];
    
    NSDecimalNumber *numDecimal = numVal;//[[NSDecimalNumber alloc] initWithString:strVal];
    NSString *strRet = [numVal stringValue];
    
    // (nVal > -1000.0 && nVal < 1000.0)
    if ([numDecimal compare:@(-1000.0)] == NSOrderedDescending &&
        [numDecimal compare:@(1000.0)] == NSOrderedAscending)
    {
        NSDecimalNumber *numDiv = [[NSDecimalNumber alloc] initWithString:@"1"];
        
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        numDecimal = [numDecimal decimalNumberByDividingBy:numDiv withBehavior:behavior];
        
        // Decimal zero
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMinimumIntegerDigits:1];
        NSString *numberAsString = [numberFormatter stringFromNumber:numDecimal];
        strRet = [NSString stringWithFormat:@"%@", numberAsString];
        
        return strRet;
    }
    
    // (nVal > -1000000.0 && nVal < 1000000.0)
    else if ([numDecimal compare:@(-1000000.0)] == NSOrderedDescending &&
             [numDecimal compare:@(1000000.0)] == NSOrderedAscending)
    {
        NSDecimalNumber *numDiv = [[NSDecimalNumber alloc] initWithString:@"1000"];
        
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:mode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        numDecimal = [numDecimal decimalNumberByDividingBy:numDiv withBehavior:behavior];
        
        // Decimal zero
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMaximumFractionDigits:scale];   // <-- Max
        NSString *numberAsString = [numberFormatter stringFromNumber:numDecimal];
        strRet = [NSString stringWithFormat:@"%@K", numberAsString];
        
    }
    // (nVal > -1000000000.0 && nVal < 1000000000.0)
    else if ([numDecimal compare:@(-1000000000.0)] == NSOrderedDescending &&
             [numDecimal compare:@(1000000000.0)] == NSOrderedAscending)
    {
        NSDecimalNumber *numDiv = [[NSDecimalNumber alloc] initWithString:@"1000000"];
        
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:mode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        numDecimal = [numDecimal decimalNumberByDividingBy:numDiv withBehavior:behavior];
        
        // Decimal zero
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMaximumFractionDigits:scale];
        NSString *numberAsString = [numberFormatter stringFromNumber:numDecimal];
        strRet = [NSString stringWithFormat:@"%@M", numberAsString];
    }
    // (nVal > -1000000000000.0 && nVal < 1000000000000.0)
    else if ([numDecimal compare:@(-1000000000000.0)] == NSOrderedDescending &&
             [numDecimal compare:@(1000000000000.0)] == NSOrderedAscending)
    {
        NSDecimalNumber *numDiv = [[NSDecimalNumber alloc] initWithString:@"1000000000"];
        
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:mode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        numDecimal = [numDecimal decimalNumberByDividingBy:numDiv withBehavior:behavior];
        
        // Decimal zero
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMaximumFractionDigits:scale];
        NSString *numberAsString = [numberFormatter stringFromNumber:numDecimal];
        strRet = [NSString stringWithFormat:@"%@B", numberAsString];
    }
    return strRet;
}


+ (NSString *)formatToChineseAbbrNumber:(NSDecimalNumber *)numVal withComma:(BOOL)bComma dataMgr:(id)dataMgr
{
    // EN版, 用千位點
    BOOL isEN = [FDTOCTools getDeviceLanguage] == EN; //[[self getDeviceLanguage] isEqualToString:@"EN"];
    if (isEN) {
        return [self formatToKMBNumber:numVal];
    }
    
    BOOL trad = [FDTOCTools getDeviceLanguage] == TW; //[[self getDeviceLanguage] isEqualToString:@"TW"];
    
    if (numVal == nil)
        numVal = [[NSDecimalNumber alloc] initWithDouble:0.0];
    if (numVal == [NSDecimalNumber notANumber])
        numVal = [[NSDecimalNumber alloc] initWithDouble:0.0];
    
    NSDecimalNumber *numDecimal = numVal;
    NSString *strRet = [numVal stringValue];
    
    if ([numDecimal isGreaterThan:[[NSDecimalNumber alloc] initWithString:@"-100000.0"]] &&
        [numDecimal isLesserThan:[[NSDecimalNumber alloc] initWithString:@"100000.0"]])
    {
        if (bComma) {
            return [self formatToDecimalFreeDollarNumber:numVal withComma:bComma];
        }
        else
            return strRet;
    }
    
    // (nVal > -100000000.0 && nVal < 100000000.0)
    else if ([numDecimal isGreaterThan:[[NSDecimalNumber alloc] initWithString:@"-100000000.0"]] &&
             [numDecimal isLesserThan:[[NSDecimalNumber alloc] initWithString:@"100000000.0"]])
    {
        NSDecimalNumber *numDiv = [[NSDecimalNumber alloc] initWithString:@"10000"];
        
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        numDecimal = [numDecimal decimalNumberByDividingBy:numDiv withBehavior:behavior];
        
        // Decimal zero
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMaximumFractionDigits:PL_DIGIT];   // <-- Max
        [numberFormatter setMinimumFractionDigits:PL_DIGIT];
        NSString *numberAsString = [numberFormatter stringFromNumber:numDecimal];
        if (trad) {
            strRet = [NSString stringWithFormat:@"%@萬", numberAsString];
        }
        else
        {
            strRet = [NSString stringWithFormat:@"%@万", numberAsString];
        }
        
    }
    // (nVal > -1000000000000 && nVal < 1000000000000)
    else if ([numDecimal isGreaterThan:[[NSDecimalNumber alloc] initWithString:@"-1000000000000"]] &&
             [numDecimal isLesserThan:[[NSDecimalNumber alloc] initWithString:@"1000000000000"]])
    {
        NSDecimalNumber *numDiv = [[NSDecimalNumber alloc] initWithString:@"100000000"];
        
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        numDecimal = [numDecimal decimalNumberByDividingBy:numDiv withBehavior:behavior];
        
        // Decimal zero
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMaximumFractionDigits:PL_DIGIT];
        [numberFormatter setMinimumFractionDigits:PL_DIGIT];
        NSString *numberAsString = [numberFormatter stringFromNumber:numDecimal];
        if (trad) {
            strRet = [NSString stringWithFormat:@"%@億", numberAsString];
        }
        else
        {
            strRet = [NSString stringWithFormat:@"%@亿", numberAsString];
        }
        
    }
    else if ([numDecimal isGreaterThan:[[NSDecimalNumber alloc] initWithString:@"-10000000000000000"]] &&
             [numDecimal isLesserThan:[[NSDecimalNumber alloc] initWithString:@"10000000000000000"]])
    {
        NSDecimalNumber *numDiv = [[NSDecimalNumber alloc] initWithString:@"1000000000000"];
        
        NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        numDecimal = [numDecimal decimalNumberByDividingBy:numDiv withBehavior:behavior];
        
        // Decimal zero
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMaximumFractionDigits:PL_DIGIT];
        [numberFormatter setMinimumFractionDigits:PL_DIGIT];
        NSString *numberAsString = [numberFormatter stringFromNumber:numDecimal];
        strRet = [NSString stringWithFormat:@"%@兆", numberAsString];
    }
    return strRet;
}

+ (NSString *)formatToChineseAbbrNumber:(NSDecimalNumber *)numVal withComma:(BOOL)bComma
{
    return [self formatToChineseAbbrNumber:numVal withComma:bComma dataMgr:nil];
}

+ (NSString *)formatToDecimalFreeDollarNumber:(NSDecimalNumber *)numVal withComma:(BOOL)bComma
{
    return [self formatToDecimalFreeDollarNumber:numVal roundMode:NSRoundPlain withComma:bComma];
}

+ (NSString *)formatToDecimalFreeDollarNumber:(NSDecimalNumber *)numVal roundMode:(NSRoundingMode)roundMode withComma:(BOOL)bComma
{
    if (numVal == nil)
        numVal = [[NSDecimalNumber alloc] initWithDouble:0.0];
    if (numVal == [NSDecimalNumber notANumber])
        numVal = [[NSDecimalNumber alloc] initWithDouble:0.0];
    
    NSDecimalNumber *numDecimal = numVal;
    NSString *strRet = [numVal stringValue];
    
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundMode scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    numDecimal = [numDecimal decimalNumberByRoundingAccordingToBehavior:behavior];
    
    // Decimal zero
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMinimumIntegerDigits:1];
    
    // Commas
    if (bComma)
    {
        NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
        [numberFormatter setGroupingSeparator:groupingSeparator];
        [numberFormatter setGroupingSize:3];
        [numberFormatter setAlwaysShowsDecimalSeparator:NO];
        [numberFormatter setUsesGroupingSeparator:YES];
    }
    
    NSString *numberAsString = [numberFormatter stringFromNumber:numDecimal];
    strRet = [NSString stringWithFormat:@"%@", numberAsString];
    
    return strRet;
}

+ (NSString *)formatToFixDigitNumber:(NSDecimalNumber *)numVal totalDigit:(int)digit
{
    if (numVal == nil)
        numVal = [[NSDecimalNumber alloc] initWithDouble:0.0];
    if (numVal == [NSDecimalNumber notANumber])
        numVal = [[NSDecimalNumber alloc] initWithDouble:0.0];
    
    NSString *strVal = [numVal stringValue];
    NSMutableString *strRet = [NSMutableString new];
    
    // num < 0 ?
    int nStartIndex = 0;
    if ([numVal compare:@(0.0)] == NSOrderedAscending)
    {
        [strRet appendString:@"-"];
        nStartIndex = 1;
        digit++;
    }
    
    // 小數點?
    if ([strVal rangeOfString:@"."].location != NSNotFound)
        digit++;
    
    for (int i = nStartIndex; i < digit; i++)
    {
        unichar aChar = (unichar)'0';
        if (i < strVal.length)
            aChar = [strVal characterAtIndex:i];
        [strRet appendFormat:@"%c", aChar];
    }
    
    return strRet;
}

+ (NSString *)formatToFixDeciamlNumber:(NSDecimalNumber *)numVal deciamlDigit:(int)digit
{
    if (numVal == nil)
        numVal = [[NSDecimalNumber alloc] initWithDouble:0.0];
    if (numVal == [NSDecimalNumber notANumber])
        numVal = [[NSDecimalNumber alloc] initWithDouble:0.0];
    
    if (digit < 0)
        return [numVal stringValue];
    
    NSString *strVal = [numVal stringValue];
    NSMutableString *strRet = [NSMutableString new];
    
    NSArray *arrNum = [strVal componentsSeparatedByString:@"."];
    [strRet appendFormat:@"%@", [arrNum firstObject]];
    
    if (digit != 0)
        [strRet appendFormat:@"%@", @"."];

    
    NSString *strDeciamlPool = @"";
    if ([arrNum count] == 2)
        strDeciamlPool = [arrNum lastObject];
    
    for (int i = 0; i < digit; i++)
    {
        unichar c = '0';
        if ([strDeciamlPool length] > i)
              c = [strDeciamlPool characterAtIndex:i];
        [strRet appendFormat:@"%c", c];
    }
    
    return strRet;
}

+ (NSString *)formatToWMFXStyle:(NSDecimalNumber *)decimalNumber withDeciamlDigit:(int)digit
{
    NSArray *arrNumeric = [decimalNumber.stringValue componentsSeparatedByString:@"."];
    NSMutableString *strMutable = [NSMutableString stringWithString:[arrNumeric firstObject]];
    NSString *strPostDot = nil;
    if ([arrNumeric count] == 2)
        strPostDot = [arrNumeric lastObject];
    
    for (int i = 0; i < digit; i++)
    {
        if ([strPostDot length] <= i) {
            [strMutable appendString:@"0"];
        } else {
            unichar c = [strPostDot characterAtIndex:i];
            [strMutable appendFormat:@"%c", c];
        }
    }
    
    strMutable = [NSMutableString stringWithFormat:@"%d", strMutable.intValue];
    return strMutable;
}

@end
