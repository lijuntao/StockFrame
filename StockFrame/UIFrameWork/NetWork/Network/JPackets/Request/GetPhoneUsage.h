//
//  GetPhoneUsage.h
//  MasterDataManager
//
//  Created by FDT14009Mac on 2015/7/21.
//  Copyright (c) 2015年 HKFDT. All rights reserved.
//

#import "JPacketSendBase.h"

@interface GetPhoneUsage : JPacketSendBase

@property (nonatomic, strong) NSString *txid;
@property (nonatomic, strong) NSString *phone;
-(instancetype)initWithTxid:(NSString *)txid
                      phone:(NSString *)phone;
@end
