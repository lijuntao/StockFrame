//
//  FDUtility.m
//  StockFrame
//
//  Created by fdt on 2018/7/4.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import "FDUtility.h"

@implementation FDUtility

+ (short)swapShortEndian:(short)val
{
    short num = val;
    int32_t b0,b1;
    int32_t res;
    
    // Size == 2
    {
        b0 = (num & 0x00ff) << 8u;
        b1 = (num & 0xff00) >> 8u;
        
        res = b0 | b1;
    }
    
    return res;
}

+ (int)swapIntEndian:(int)val
{
    int32_t num = val;
    int32_t b0,b1,b2,b3;
    int32_t res;
    
    // nSize == 4
    {
        b0 = (num & 0x000000ff) << 24u;
        b1 = (num & 0x0000ff00) << 8u;
        b2 = (num & 0x00ff0000) >> 8u;
        b3 = (num & 0xff000000) >> 24u;
        
        res = b0 | b1 | b2 | b3;
    }
    
    return res;
}

+ (long long)swapLongLongEndian:(long long)val
{
    long long res;
    
    // nSize == 8
    {
        long ret;
        
        char *longInput = (char *)&val;
        char *longOutput = (char *)&ret;
        
        longOutput[0] = longInput[7];
        longOutput[1] = longInput[6];
        longOutput[2] = longInput[5];
        longOutput[3] = longInput[4];
        longOutput[4] = longInput[3];
        longOutput[5] = longInput[2];
        longOutput[6] = longInput[1];
        longOutput[7] = longInput[0];
        
        res = ret;
    }
    
    return res;
}

+ (float)swapFloatEndian:(float)val
{
    float ret;
    
    char *floatInput = (char *)&val;
    char *floatOutput = (char *)&ret;
    
    floatOutput[0] = floatInput[3];
    floatOutput[1] = floatInput[2];
    floatOutput[2] = floatInput[1];
    floatOutput[3] = floatInput[0];
    
    return ret;
}

+ (double)swapDoubleEndian:(double)val
{
    double ret;
    
    char *doubleInput = (char *)&val;
    char *doubleOutput = (char *)&ret;
    
    doubleOutput[0] = doubleInput[7];
    doubleOutput[1] = doubleInput[6];
    doubleOutput[2] = doubleInput[5];
    doubleOutput[3] = doubleInput[4];
    doubleOutput[4] = doubleInput[3];
    doubleOutput[5] = doubleInput[2];
    doubleOutput[6] = doubleInput[1];
    doubleOutput[7] = doubleInput[0];
    
    return ret;
}

@end
