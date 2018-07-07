//
//  WmGetTradeHistoryUpdate.h
//  MasterDataManager
//
//  Created by 姚晨峰 on 2017/5/2.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"
#import "WmTradeItem.h"
@interface WmGetTradeHistoryUpdate : JPacketReceiveBase
@property (nonatomic,copy) NSString *user;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *start_date;
@property (nonatomic,copy) NSString *end_date;
@property (nonatomic,strong) NSArray<WmTradeItem *> *d;
@end
