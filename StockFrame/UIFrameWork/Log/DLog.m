//
//  FDTLog.m
//  StockFrame
//
//  Created by fdt on 2018/7/5.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import "DLog.h"


#ifdef DEBUG
static const int ddLogLevel = DDLogLevelDebug;
#else
static const int ddLogLevel = DDLogLevelOff;
#endif

@implementation DLog


static DLog* instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        return self;
    }
    return self;
}

+ (void)initLog {
    #if DEBUG
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
    #else
        [DDLog addLogger:[DDASLLogger sharedInstance]];
    
        // 添加DDFileLogger，你的日志语句将写入到一个文件中，
        // 默认路径在沙盒的Library/Caches/Logs/目录下，文件名为bundleid+空格+日期.log。
        DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // 本地文件日志
        fileLogger.rollingFrequency = 60 * 60 * 24; // 每24小时创建一个新文件
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7; // 最多允许创建7个文件
        [DDLog addLogger:fileLogger];
    #endif
}

+ (void)logDebug:(NSString *)message {
    DDLogDebug(@"%@",message);
}

+ (void)logInfo: (NSString *)message {
    DDLogInfo(@"%@",message);
}

@end
