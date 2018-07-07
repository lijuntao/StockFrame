//
//  WmGetTradeHistory.h
//  MasterDataManager
//
//  Created by 姚晨峰 on 2017/5/2.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"
/**
 历史成交
 
 - returns: 
 */
@interface WmGetTradeHistory : JPacketSendBase
-(id)initWithStart:(NSString *)start end:(NSString *)end;


//开始时间 yyyy/MM/ddd
@property(nonatomic, copy) NSString *start_date;
//结束时间 yyyy/MM/ddd
@property(nonatomic, copy) NSString *end_date;
@end
