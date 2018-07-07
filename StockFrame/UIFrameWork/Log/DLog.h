//
//  DLog.h
//  StockFrame
//
//  Created by fdt on 2018/7/5.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface DLog : NSObject
+ (instancetype) shareInstance;
+ (void)initLog;
+ (void)logDebug:(NSString *)message;
+ (void)logInfo:(NSString *)message;
@end
