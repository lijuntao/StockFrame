//
//  FDTDataFormatter.m
//  StockFrame
//
//  Created by fdt on 2018/7/25.
//  Copyright © 2018年 ljt. All rights reserved.
//

#import "FDTDataFormatter.h"
static NSString *timeZoneBJName = @"Asia/Shanghai";
static FDTDataFormatter *singletonInstance = nil;
@interface FDTDataFormatter()
//093000
@property (nonatomic, strong) NSDateFormatter *HHmmssFormatter;
//09:30:00
@property (nonatomic, strong) NSDateFormatter *ColonHHmmssFormatter;
@end
@implementation FDTDataFormatter

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonInstance = [[self alloc] init];
    });
    return singletonInstance;
}

- (NSDateFormatter *)getHHmmss {
    if (self.HHmmssFormatter == nil) {
        self.HHmmssFormatter = [[NSDateFormatter alloc] init];
        self.HHmmssFormatter.dateFormat = @"yyyy-MM-dd HHmmss";
        self.HHmmssFormatter.timeZone = [NSTimeZone timeZoneWithName:timeZoneBJName];
    }
    return self.HHmmssFormatter;
}

- (NSDateFormatter *)getColonHHmmss {
    if (self.ColonHHmmssFormatter == nil) {
        self.ColonHHmmssFormatter = [[NSDateFormatter alloc] init];
        self.ColonHHmmssFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        self.HHmmssFormatter.timeZone = [NSTimeZone timeZoneWithName:timeZoneBJName];
    }
    return self.ColonHHmmssFormatter;
}

@end
