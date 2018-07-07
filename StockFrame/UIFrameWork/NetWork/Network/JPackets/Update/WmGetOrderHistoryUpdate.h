//
//  WmGetOrderHistoryUpdate.h
//  MasterDataManager
//
//  Created by 姚晨峰 on 2017/4/28.
//  Copyright © 2017年 HKFDT. All rights reserved.
//

#import "JPacketReceiveBase.h"
#import "WmOrderItem.h"


@interface WmGetOrderHistoryUpdate : JPacketReceiveBase
@property (nonatomic,copy) NSString *user;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *start_date;
@property (nonatomic,copy) NSString *end_date;
@property (nonatomic,strong) NSArray<WmOrderItem *> *d;
@end
