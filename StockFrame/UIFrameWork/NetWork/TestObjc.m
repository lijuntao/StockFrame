//
//  TestObjc.m
//  StockFrame
//
//  Created by fdt on 2018/7/5.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import "TestObjc.h"
#import "NetworkDefinition.h"
@implementation TestObjc

- (void)test {
    for (int i = 0; i < 10000; i++) {
        LogDebug(@"ljt -%@ -%@/%d",@"12121",@"8888",i);
    }
}
@end
